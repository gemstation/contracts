#!/usr/bin/env node
let $

(async () => {
  $ = (await import('execa')).$

  const addresses = require('../gemforge.deployments.json')

  for (let chainId in addresses) {
    // skip localhost
    if (chainId === '31337') {
      continue
    }

    console.log(`Verifying on chain ${chainId} ...`)

    const contracts = addresses[chainId] || []

    for (let { name, contract } of contracts) {
      let args = '0x'

      if (contract.constructorArgs.length) {
        args = (await $`cast abi-encode constructor(address) ${contract.constructorArgs.join(' ')}`).stdout
      }

      console.log(`Verifying ${name} at ${contract.address} with args ${args}`)

      await $`forge verify-contract ${contract.address} ${name} --constructor-args ${args} --chain-id ${chainId} --verifier etherscan --etherscan-api-key ${process.env.ETHERSCAN_API_KEY} --watch`

      console.log(`Verified!`)
    }
  }
})()
