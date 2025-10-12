// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@uniswap/v3-periphery/contracts/interfaces/IPeripheryImmutableState.sol";
import "../interfaces/IDexAdapter.sol";
import "../interfaces/ISwapRouter02.sol";
import "../interfaces/IUniswapV2Factory.sol";
import "../interfaces/IUniswapV2Pair.sol";
import "../interfaces/IUniswapV2Router02.sol";
import "../interfaces/IV3TwapUtilities.sol";

contract UniswapDexAdapter is IDexAdapter, Context {
    using SafeERC20 for IERC20;

    IV3TwapUtilities public immutable V3_TWAP_UTILS;
    address public immutable override V2_ROUTER;
    address public immutable override V3_ROUTER;
    bool public immutable override ASYNC_INITIALIZE;

    constructor(IV3TwapUtilities _v3TwapUtilities, address _v2Router, address _v3Router, bool _asyncInit) {
        V3_TWAP_UTILS = _v3TwapUtilities;
        V2_ROUTER = _v2Router;
        V3_ROUTER = _v3Router;
        ASYNC_INITIALIZE = _asyncInit;
    }

    function WETH() external view virtual override returns (address) {
        return IUniswapV2Router02(V2_ROUTER).WETH();
    }

    function getV3Pool(address, address, int24) external view virtual override returns (address _p) {
        _p;
        require(false, "I0");
    }

    function getV3Pool(address _token0, address _token1, uint24 _poolFee)
        external
        view
        virtual
        override
        returns (address)
    {
        return V3_TWAP_UTILS.getV3Pool(IPeripheryImmutableState(V3_ROUTER).factory(), _token0, _token1, _poolFee);
    }

    function getV2Pool(address _token0, address _token1) external view virtual override returns (address) {
        return IUniswapV2Factory(IUniswapV2Router02(V2_ROUTER).factory()).getPair(_token0, _token1);
    }

    function getReserves(address _pool) external view virtual override returns (uint112 _reserve0, uint112 _reserve1) {
        (_reserve0, _reserve1,) = IUniswapV2Pair(_pool).getReserves();
    }

    function createV2Pool(address _token0, address _token1) external virtual override returns (address) {
        return IUniswapV2Factory(IUniswapV2Router02(V2_ROUTER).factory()).createPair(_token0, _token1);
    }

    function swapV2Single(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOutMin,
        address _recipient
    ) external virtual override returns (uint256 _amountOut) {
        uint256 _outBefore = IERC20(_tokenOut).balanceOf(_recipient);
        if (_amountIn == 0) {
            _amountIn = IERC20(_tokenIn).balanceOf(address(this));
        } else {
            IERC20(_tokenIn).safeTransferFrom(_msgSender(), address(this), _amountIn);
        }
        address[] memory _path = new address[](2);
        _path[0] = _tokenIn;
        _path[1] = _tokenOut;
        IERC20(_tokenIn).safeIncreaseAllowance(V2_ROUTER, _amountIn);
        IUniswapV2Router02(V2_ROUTER).swapExactTokensForTokensSupportingFeeOnTransferTokens(
            _amountIn, _amountOutMin, _path, _recipient, block.timestamp
        );
        return IERC20(_tokenOut).balanceOf(_recipient) - _outBefore;
    }

    function swapV2SingleExactOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountInMax,
        uint256 _amountOut,
        address _recipient
    ) external virtual override returns (uint256 _amountInUsed) {
        uint256 _inBefore = IERC20(_tokenIn).balanceOf(address(this));
        if (_amountInMax == 0) {
            _amountInMax = IERC20(_tokenIn).balanceOf(address(this));
        } else {
            IERC20(_tokenIn).safeTransferFrom(_msgSender(), address(this), _amountInMax);
        }
        address[] memory _path = new address[](2);
        _path[0] = _tokenIn;
        _path[1] = _tokenOut;
        IERC20(_tokenIn).safeIncreaseAllowance(V2_ROUTER, _amountInMax);
        IUniswapV2Router02(V2_ROUTER).swapTokensForExactTokens(
            _amountOut, _amountInMax, _path, _recipient, block.timestamp
        );
        uint256 _inRemaining = IERC20(_tokenIn).balanceOf(address(this)) - _inBefore;
        if (_inRemaining > 0) {
            IERC20(_tokenIn).safeTransfer(_msgSender(), _inRemaining);
        }
        _amountInUsed = _amountInMax - _inRemaining;
    }

    function swapV3Single(
        address _tokenIn,
        address _tokenOut,
        uint24 _fee,
        uint256 _amountIn,
        uint256 _amountOutMin,
        address _recipient
    ) external virtual override returns (uint256 _amountOut) {
        uint256 _outBefore = IERC20(_tokenOut).balanceOf(_recipient);
        if (_amountIn == 0) {
            _amountIn = IERC20(_tokenIn).balanceOf(address(this));
        } else {
            IERC20(_tokenIn).safeTransferFrom(_msgSender(), address(this), _amountIn);
        }
        IERC20(_tokenIn).safeIncreaseAllowance(V3_ROUTER, _amountIn);
        ISwapRouter02(V3_ROUTER).exactInputSingle(
            ISwapRouter02.ExactInputSingleParams({
                tokenIn: _tokenIn,
                tokenOut: _tokenOut,
                fee: _fee,
                recipient: _recipient,
                amountIn: _amountIn,
                amountOutMinimum: _amountOutMin,
                sqrtPriceLimitX96: 0
            })
        );
        return IERC20(_tokenOut).balanceOf(_recipient) - _outBefore;
    }

    function addLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _amountADesired,
        uint256 _amountBDesired,
        uint256 _amountAMin,
        uint256 _amountBMin,
        address _to,
        uint256 _deadline
    ) external virtual override {
        uint256 _aBefore = IERC20(_tokenA).balanceOf(address(this));
        uint256 _bBefore = IERC20(_tokenB).balanceOf(address(this));
        IERC20(_tokenA).safeTransferFrom(_msgSender(), address(this), _amountADesired);
        IERC20(_tokenB).safeTransferFrom(_msgSender(), address(this), _amountBDesired);
        IERC20(_tokenA).safeIncreaseAllowance(V2_ROUTER, _amountADesired);
        IERC20(_tokenB).safeIncreaseAllowance(V2_ROUTER, _amountBDesired);
        IUniswapV2Router02(V2_ROUTER).addLiquidity(
            _tokenA, _tokenB, _amountADesired, _amountBDesired, _amountAMin, _amountBMin, _to, _deadline
        );
        if (IERC20(_tokenA).balanceOf(address(this)) > _aBefore) {
            IERC20(_tokenA).safeTransfer(_to, IERC20(_tokenA).balanceOf(address(this)) - _aBefore);
        }
        if (IERC20(_tokenB).balanceOf(address(this)) > _bBefore) {
            IERC20(_tokenB).safeTransfer(_to, IERC20(_tokenB).balanceOf(address(this)) - _bBefore);
        }
    }

    function removeLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _liquidity,
        uint256 _amountAMin,
        uint256 _amountBMin,
        address _to,
        uint256 _deadline
    ) external virtual override {
        address _pool = IUniswapV2Factory(IUniswapV2Router02(V2_ROUTER).factory()).getPair(_tokenA, _tokenB);
        uint256 _lpBefore = IERC20(_pool).balanceOf(address(this));
        IERC20(_pool).safeTransferFrom(_msgSender(), address(this), _liquidity);
        IERC20(_pool).safeIncreaseAllowance(V2_ROUTER, _liquidity);
        IUniswapV2Router02(V2_ROUTER).removeLiquidity(
            _tokenA, _tokenB, _liquidity, _amountAMin, _amountBMin, _to, _deadline
        );
        if (IERC20(_pool).balanceOf(address(this)) > _lpBefore) {
            IERC20(_pool).safeTransfer(_to, IERC20(_pool).balanceOf(address(this)) - _lpBefore);
        }
    }
}
