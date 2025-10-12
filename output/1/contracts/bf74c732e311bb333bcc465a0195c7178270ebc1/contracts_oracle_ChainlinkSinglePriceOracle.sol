// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV2V3Interface.sol";
import "../interfaces/IMinimalSinglePriceOracle.sol";

interface IEACAggregatorProxy {
    function aggregator() external view returns (address);
}

interface IOffchainAggregator {
    function minAnswer() external view returns (int192);

    function maxAnswer() external view returns (int192);
}

contract ChainlinkSinglePriceOracle is IMinimalSinglePriceOracle, Ownable {
    error GracePeriodNotOver();
    error SequencerDown();

    event SetDefaultMaxOracleDelay(uint256 _oldDelay, uint256 _newDelay);
    event SetMaxOracleDelay(address _feed, uint256 _oldDelay, uint256 _newDelay);

    uint256 private constant SEQ_GRACE_PERIOD = 3600;

    /// @notice Only needed is we're on an L2 and there exists a data object to check for sequencer uptime
    AggregatorV2V3Interface _sequencerUptimeFeed;

    uint256 public defaultMaxOracleDelay = 1 days;
    // feed => delay seconds
    mapping(address => uint256) public feedMaxOracleDelay;

    /// @notice If L1 or no sequencer needed on L2 pass address(0)
    constructor(address _sequencer) Ownable(_msgSender()) {
        _sequencerUptimeFeed = AggregatorV2V3Interface(_sequencer);
    }

    /// @notice The ```getPriceUSD18``` function gets the QUOTE/BASE price (mathematically BASE per QUOTE)
    /// @param _priceFeedQuote Chainlink price feed representing the quote token, probably quote/USD (mathematically USD per quote)
    /// @param _priceFeedBase Chainlink price feed representing the base token, probably quote/USD (mathematically USD per base)
    /// @return _isBadData Whether the oracle is returning what we should assume is bad data
    /// @return _price18 Number representing the price with 1e18 precision
    function getPriceUSD18(address _priceFeedQuote, address _priceFeedBase, address, uint256)
        external
        view
        virtual
        override
        returns (bool _isBadData, uint256 _price18)
    {
        _sequencerCheck();

        uint256 _quoteUpdatedAt;
        bool _quoteIsBad;
        uint256 _maxDelayQuote =
            feedMaxOracleDelay[_priceFeedQuote] > 0 ? feedMaxOracleDelay[_priceFeedQuote] : defaultMaxOracleDelay;
        uint256 _isBadTimeQuote = block.timestamp - _maxDelayQuote;
        (_price18, _quoteUpdatedAt, _quoteIsBad) = _getChainlinkPriceFeedPrice18(_priceFeedQuote);
        _isBadData = _quoteIsBad || _quoteUpdatedAt < _isBadTimeQuote;

        uint256 _maxDelayBase =
            feedMaxOracleDelay[_priceFeedBase] > 0 ? feedMaxOracleDelay[_priceFeedBase] : defaultMaxOracleDelay;
        uint256 _isBadTimeBase = block.timestamp - _maxDelayBase;
        if (_priceFeedBase != address(0)) {
            (uint256 _basePrice18, uint256 _baseUpdatedAt, bool _baseIsBad) =
                _getChainlinkPriceFeedPrice18(_priceFeedBase);
            _price18 = (10 ** 18 * _price18) / _basePrice18;
            _isBadData = _isBadData || _baseIsBad || _baseUpdatedAt < _isBadTimeBase;
        }
    }

    function _getChainlinkPriceFeedPrice18(address _priceFeed)
        internal
        view
        returns (uint256 _price18, uint256 _updatedAt, bool _isBadAnswer)
    {
        uint8 _decimals = AggregatorV2V3Interface(_priceFeed).decimals();
        (, int256 _price,, uint256 _lastUpdated,) = AggregatorV2V3Interface(_priceFeed).latestRoundData();
        _isBadAnswer = _price <= 0 || !_isValidAnswer(_priceFeed, _price);
        _price18 = (uint256(_price) * 10 ** 18) / 10 ** _decimals;
        _updatedAt = _lastUpdated;
    }

    function _sequencerCheck() internal view {
        if (address(_sequencerUptimeFeed) == address(0)) {
            return;
        }

        (
            ,
            /*uint80 roundID*/
            int256 answer,
            uint256 _startedAt, /*uint256 updatedAt*/ /*uint80 answeredInRound*/
            ,
        ) = _sequencerUptimeFeed.latestRoundData();

        // Answer == 0: Sequencer is up
        // Answer == 1: Sequencer is down
        bool _isSequencerUp = answer == 0;
        if (!_isSequencerUp) {
            revert SequencerDown();
        }

        // Make sure the grace period has passed after the
        // sequencer is back up.
        uint256 _timeSinceUp = block.timestamp - _startedAt;
        if (_timeSinceUp <= SEQ_GRACE_PERIOD) {
            revert GracePeriodNotOver();
        }
    }

    function _isValidAnswer(address _feed, int256 _answer) internal view returns (bool _isValid) {
        _isValid = true;
        int192 _min = IOffchainAggregator(IEACAggregatorProxy(_feed).aggregator()).minAnswer();
        int192 _max = IOffchainAggregator(IEACAggregatorProxy(_feed).aggregator()).maxAnswer();

        if (_answer > _max || _answer < _min) {
            _isValid = false;
        }
    }

    function setFeedMaxOracleDelay(address _feed, uint256 _newDelaySeconds) external onlyOwner {
        uint256 _current = feedMaxOracleDelay[_feed];
        feedMaxOracleDelay[_feed] = _newDelaySeconds;
        emit SetMaxOracleDelay(_feed, _current, _newDelaySeconds);
    }

    function setMaxOracleDelay(uint256 _newDelaySeconds) external onlyOwner {
        uint256 _current = defaultMaxOracleDelay;
        defaultMaxOracleDelay = _newDelaySeconds;
        emit SetDefaultMaxOracleDelay(_current, _newDelaySeconds);
    }
}
