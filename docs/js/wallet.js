if (window.cardano) {
    console.log("Wallets detected:", Object.keys(window.cardano));
} else {
    console.error("No wallets detected!");
}

// Connect to a wallet
async function connectWallet() {
    try {
        const nami = await window.cardano.nami.enable();
        const address = await nami.getUsedAddresses();
        console.log("Connected wallet address:", address);
    } catch (error) {
        console.error("Error connecting wallet:", error);
    }
}

async function getWalletAddress() {
    const nami = await window.cardano.nami.enable();
    const addresses = await nami.getUsedAddresses();
    console.log("Wallet address:", addresses[0]); // Display first address
}


import { Lucid } from "lucid-cardano";

async function sendTransaction() {
    const lucid = await Lucid.new();
    lucid.selectWallet(await window.cardano.nami.enable());

    const tx = await lucid
        .newTx()
        .payToAddress("recipient_address_here", { lovelace: 1000000 })
        .complete();

    const signedTx = await tx.sign().complete();
    const txHash = await signedTx.submit();

    console.log("Transaction submitted:", txHash);
}