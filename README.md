# Stacks Builder NFT

Stacks Builder is a limited-supply NFT collection (100 total) built on Base Network. It serves as a genesis pass for builders and early adopters within the ecosystem.

## Overview
- **Network:** Base
- **Total Supply:** 100
- **Mint Limit:** 2 Per Wallet
- **Mint Price:** Free (Gas only)

## Future Utilities
The Stacks Builder NFT acts as a utility gate for several upcoming features:

1. **Perpetual DEX Whitelist:** Guaranteed early access to high-leverage trading platforms on Base (e.g., Polymarket-style predictors or Perp DEXs).
2. **Dynamic Fee Rebates:** Reduced trading fees for holders across partner decentralized applications.
3. **Liquidity Provision Boost:** Extra reward weight for holders participating in specific liquidity pools.
4. **Governance Access:** Gated entry to private builder channels and strategic voting on future project directions.
5. **Airdrop Gating:** Exclusive eligibility for future ecosystem token distributions.

## Implementation Details
The contract is a custom, self-contained ERC721 implementation designed to minimize gas costs during deployment and minting. It removes all external dependencies to ensure seamless verification on BaseScan.

## License
MIT
