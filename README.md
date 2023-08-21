# @gemstation/contracts-foundry

Scaffolding for [gemforge](https://gemforge.xyz) using [Foundry](https://github.com/foundry-rs/foundry).

This contains the optimal folder structure for use with `gemforge`, including:

* Diamond standard library contracts imported as a git module
* Post-deploy hook for Etherscan verification
* ERC20 facade as an example

## Requirements

* [Node.js 20+](https://nodejs.org)
* [PNPM](https://pnpm.io/) _(NOTE: `yarn` and `npm` can also be used)_
* [Foundry](https://github.com/foundry-rs/foundry/blob/master/README.md)

## Installation

In a fresh folder:

```
npx gemforge scaffold
```

Change into the folder and run in order:

```
$ foundryup
$ forge install foundry-rs/forge-std
$ pnpm i
$ git submodule update --init --recursive
```

Create `.env` and set the following within:

```
LOCAL_RPC_URL=http://localhost:8545
SEPOLIA_RPC_URL=<your infura/alchemy endpoint for spolia>
ETHERSCAN_API_KEY=<your etherscan api key>
MNEMONIC=<your deployment wallet mnemonic>
```

## Usage

Run a local dev node in a separate terminal:

```
pnpm devnet
```

To build the code:

```
$ pnpm build
```

To deploy to the local node:

```
$ pnpm deploy-contracts
```

To deploy to Sepolia testnet:

```
$ pnpm dep sepolia
```

For verbose output simply add `-v`:

```
$ pnpm build -v
$ pnpm dep -v
```

## Gemforge

The `build` and `deploy` commands internally call through to `gemforge`. The `gemforge.config.cjs` file contains all the configuration - please customize as you see fit.

For full gemforge documentation please see [gemforge.xyz](https://gemforge.xyz).

## License

MIT - see [LICSENSE.md](LICENSE.md)
