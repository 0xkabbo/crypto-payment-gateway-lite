# Crypto Payment Gateway Lite

This repository provides a high-quality, lightweight solution for merchants looking to accept cryptocurrency payments directly on-chain. It eliminates the need for third-party processors, ensuring immediate settlement and full control over funds.

## Features
- **Multi-Asset Support:** Accept native ETH and any standard ERC-20 tokens.
- **Merchant Controls:** Securely manage withdrawal addresses and transaction fees.
- **Event-Driven:** Emits detailed events for backend indexing and payment verification.
- **Flat Structure:** Single-directory layout for rapid deployment and simple integration.

## How It Works
1. **Invoice Generation:** The merchant generates a unique `paymentId`.
2. **Customer Payment:** The customer calls `payWithToken` or `payWithEth`.
3. **Verification:** The merchant's backend listens for the `PaymentReceived` event.
4. **Settlement:** Funds are instantly accessible for the merchant.

## License
MIT
