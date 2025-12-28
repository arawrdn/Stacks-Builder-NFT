import { createAppKit } from 'https://esm.sh/@reown/appkit'
import { EthersAdapter } from 'https://esm.sh/@reown/appkit-adapter-ethers'
import { base } from 'https://esm.sh/@reown/appkit/networks'
import { ethers } from 'https://esm.sh/ethers@6.x'

// 1. Configuration
const projectId = 'a5f9260bc9bca570190d3b01f477fc45';
const contractAddress = '0xa4Ca9151401E65ecC170aF86aFD6c7A06e05B7e8';
const contractABI = [
    "function mint(uint256 quantity) external",
    "function mintLive() public view returns (bool)",
    "function mintedPerWallet(address) public view returns (uint256)"
];

// 2. Initialize AppKit
const modal = createAppKit({
  adapters: [new EthersAdapter()],
  networks: [base],
  metadata: {
    name: 'Stacks Builder NFT',
    description: 'Mint your Stacks Builder NFT on Base',
    url: 'https://arawrdn.github.io/Stacks-Builder-NFT/',
    icons: ['https://avatars.githubusercontent.com/u/179229932']
  },
  projectId
});

// 3. Logic & State
let quantity = 1;
const mintBtn = document.getElementById('mint-btn');
const mintControls = document.getElementById('mint-controls');
const msg = document.getElementById('msg');

modal.subscribeAccount(state => {
    if (state.isConnected) {
        mintControls.classList.remove('hidden');
    } else {
        mintControls.classList.add('hidden');
    }
});

document.getElementById('inc').onclick = () => { if(quantity < 2) { quantity++; updateQty(); }};
document.getElementById('dec').onclick = () => { if(quantity > 1) { quantity--; updateQty(); }};

function updateQty() { document.getElementById('qty').innerText = quantity; }

mintBtn.onclick = async () => {
    try {
        mintBtn.disabled = true;
        mintBtn.innerText = "Processing...";
        
        const provider = new ethers.BrowserProvider(modal.getWalletProvider());
        const signer = await provider.getSigner();
        const contract = new ethers.Contract(contractAddress, contractABI, signer);

        const tx = await contract.mint(quantity);
        msg.innerText = "Transaction sent! Waiting for confirmation...";
        
        await tx.wait();
        msg.innerText = "Success! NFT Minted.";
    } catch (err) {
        console.error(err);
        msg.innerText = err.reason || "Error occurred during minting.";
    } finally {
        mintBtn.disabled = false;
        mintBtn.innerText = "MINT NOW";
    }
};
