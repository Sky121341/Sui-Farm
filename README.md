# Sui-farm-RPG-contracts

A stardew valley inspired farming on-chain RPG powered by SUI network

The SUI-Farm smart contract, developed using Move language, revolutionizes the gaming experience by providing gamers true ownership and control over their in-game assets. This innovative contract facilitates a seamless transition to Web3 by enabling players to own their digital inventory as NFTs on the SUI platform.


## The problem SUIValley solves
Currently the gamers don’t have full control on their hard earned in-game assets
Limited interactions between multiple games and experiences within the same studio.
Few opportunities for gamers to engage with other gamers and build their own persona, as the game assets are not portable outside the game
Most web3 games are gated communities and owning them only offers license to the game. That is not what true asset ownership is.
Need to improve Web3 User Experience

## SOLUTION
A smooth web2-like on-chain farming RPG that let's players enjoy the tasks of owning a land, managing resources:

Creation of Player NFT <- Creation of Inventory <- Creation of Items in Inventory at default value of 0 when user makes a new account
Collect and upgrade your inventory. The Inventory is like an NFT object on SUI, which keeps track of items on-chain, and also updates the inventory as you collect more resources on-chain
Player levels up on XP as you create, grow, harvest and expand your inventory
The game runs on a simulated engine with respect to time, which make sure elements within the objects (for instance seeds, germinate into saplings and are updated on chain using Move modules)
The flow of the game is web2 as the transactions are signed by the HD wallet provided within the Origin Byte Unity SDK
The onboarding is done through email and password JWT authentication system
Game state synced with SUI Move Objects that acts like NFTs owning NFTs
Players own invnentory, inventory owns items (seeds, saplings, harvest, tools, raw materials) and you can update the objects as you play the game on chain in a hassle free (non-web3 UX manner)