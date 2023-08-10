# @gemstation/contracts

Standardized Diamond Standard contracts. Used by [gemforge](https://github.com/gemstation/gemforge) CLI.

## Development

Requirements:

* [Node.js 20+](https://nodejs.org)
* [PNPM](https://pnpm.io/)
* [Foundry](https://github.com/foundry-rs/foundry/blob/master/README.md)

Setup steps:

- Run `foundryup`
- Run `forge install foundry-rs/forge-std`
- Run `pnpm i`
- Run `git submodule update --init --recursive`
- Run `cp .env.example .env` and set the following within:

```
export LOCAL_RPC_URL=http://localhost:8545
```

Build the contracts:

```
pnpm build
```


