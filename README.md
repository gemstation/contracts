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

Git clone:

```
$ git clone https://github.com/gemstation/contracts-foundry.git
```

Setup the folder:

```
$ foundryup
$ forge install foundry-rs/forge-std
$ pnpm i
$ git submodule update --init --recursive
```

Create `.env` and set the following within:

```
export LOCAL_RPC_URL=http://localhost:8545
export SEPOLIA_RPC_URL=<your infura/alchemy endpoint for spolia>
export ETHERSCAN_API_KEY=<your etherscan api key>
export MNEMONIC=<your deployment wallet mnemonic>
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
$ pnpm deploy
```

To deploy to Sepolia testnet:

```
$ pnpm deploy sepolia
```

For verbose output simply add `-v`:

```
$ pnpm build -v
$ pnpm deploy -v
```

## Gemforge

The `build` and `deploy` commands internally call through to `gemforge`. The `gemforge.config.cjs` file contains all the configuration - please customize as you see fit.

For full gemforge documentation please see [gemforge.xyz](https://gemforge.xyz).

## License

MIT - see [LICSENSE.md](LICENSE.md)
