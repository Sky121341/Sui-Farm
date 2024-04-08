// Importing necessary modules and types
use sui::coin::{Self as Coin};
use sui::event;
use sui::object::{Self as Object, ID as ObjectID, UID as ObjectUID};
use sui::math;
use sui::sui::SUI;
use sui::transfer;
use sui::tx_context::{Self as TxContext, TxContext};
use std::option::{Self as Option};
use std::string::{String};

// Define the module `suifarm::game`
module suifarm::game
{
    // Define the `Player` struct
    struct Player has key, store
    {
        id: ObjectUID,                      // Unique identifier for the player
        xp: u8,                             // Player's experience points
        inventory: Option<Inventory>        // Player's inventory (optional)
    }

    // Define the `Inventory` struct
    struct Inventory has key, store
    {
        id: ObjectUID,                      // Unique identifier for the inventory
        // Optional items in the inventory
        pickaxe: Option<Item>,
        axe: Option<Item>,
        basket: Option<Item>,
        corn: Option<Item>,
        parsnip: Option<Item>,
        pumpkin: Option<Item>,
        stone: Option<Item>,
        weed: Option<Item>,
        wood: Option<Item>,
        hoe: Option<Item>,
        scythe: Option<Item>,
        acorn: Option<Item>,
        parsnip_seed: Option<Item>,
        pine: Option<Item>,
        watering_can: Option<Item>
    }

    // Define the `Item` struct
    struct Item has key, store
    {
        id: ObjectUID,                      // Unique identifier for the item
        in_game_id: u16,                    // ID of the item in the game
        held: u8,                           // Quantity of the item held
        name: String,                       // Name of the item
        image_url: String,                  // URL to the image of the item
    }

    // Implementation block for the `Inventory` struct
    impl Inventory {
        // Method to unwrap the optional inventory
        fn unwrap(&self) -> &Inventory {
            match &self.inventory {
                Some(inventory) => inventory,
                None => panic!("Called `Player::unwrap_inventory()` on a `None` value"),
            }
        }
    }

    // Entry function to create a new player
    public entry fun create_player(xp: u8, ctx: &mut TxContext)
    {
        // Create a new inventory for the player
        let inventory = create_new_inventory(ctx);
        // Transfer the player object to the blockchain
        transfer::transfer(Player {
            id: Object::new(ctx),
            xp: xp,
            inventory: Option::Some(inventory)
        },
        TxContext::sender(ctx));
    }

    // Entry function to add an item to a player's inventory
    pub entry fun add_item_to_player(player_id: ObjectUID, item: Item, ctx: &mut TxContext) {
        let mut player: Player = Object::get(player_id, ctx).unwrap();
        if let Some(mut inventory) = player.inventory {
            inventory.add_item(item);
            player.inventory = Some(inventory);
            transfer::update(player, ctx);
        }
    }

    // Function to create a new inventory
   
    fun create_new_inventory(ctx: &mut TxContext): Inventory
    {
        // Create a new inventory object with initial items
        Inventory
        {
            id: object::new(ctx), 
            pickaxe: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10013,
                held: 0,
                name: string::utf8(b"Pickaxe"),
                image_url: string::utf8(b"https://bafkreicpi5dtcswo7e3dvly2upwzjse3k3dy6q3gycwfjm434nmh4bfiri.ipfs.dweb.link/")
            }),
            axe: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10005,
                held: 0,
                name: string::utf8(b"Axe"),
                image_url: string::utf8(b"https://bafkreielbw2mux3vptrzuougyt7bt4ctwgyw6igfnlnhsh6yvoz3avndem.ipfs.dweb.link/")
            }),
            basket: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10012,
                held: 0,
                name: string::utf8(b"Basket"),
                image_url: string::utf8(b"https://bafkreiaty23ypd5cjlvtmdbpngbnmvtiyltqzvctplbznfyyiwvmjhamqu.ipfs.dweb.link/")
            }),
            corn: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10002,
                held: 0,
                name: string::utf8(b"Corn"),
                image_url: string::utf8(b"https://bafkreifltsjqnye4l7wkptdvjnaz6od5ogn6vwrytumm3glgm7fcm33jrq.ipfs.dweb.link/")
            }),
            parsnip: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10007,
                held: 0,
                name: string::utf8(b"Parsnip"),
                image_url: string::utf8(b"https://bafkreia4mcrcfr6iwcrhsah57ywerws5wi7gamxj7b523qi35g5logjagy.ipfs.dweb.link/")
            }),
            pumpkin: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10001,
                held: 0,
                name: string::utf8(b"Pumpkin"),
                image_url: string::utf8(b"https://bafkreiga5iz5vmdkvgzq375ntcbs4jziyv5symfz6skmd4wtuvv36njlh4.ipfs.dweb.link/")
            }),
            stone: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10015,
                held: 0,
                name: string::utf8(b"Stone"),
                image_url: string::utf8(b"https://bafkreiehvy5d4h5xh6doiaxsss5vecbixd7ll6dcfbdolojyjtqwxzsh54.ipfs.dweb.link/")
            }),
            weed: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10020,
                held: 0,
                name: string::utf8(b"Weed"),
                image_url: string::utf8(b"https://bafkreihwayy5uko53ffhganvhfczgom7vv7wcymzfhltt77ixwsqmnkjvm.ipfs.dweb.link/")
            }),
            wood: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10008,
                held: 0,
                name: string::utf8(b"Wood"),
                image_url: string::utf8(b"https://bafkreifpgtzqvighooclv5p3czwqj7lutnoeup23oi5buoqwg7v5zhntqm.ipfs.dweb.link/")
            }),
            hoe: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10004,
                held: 0,
                name: string::utf8(b"Hoe"),
                image_url: string::utf8(b"https://bafkreibraxpnocidllmhriknwuuy6whyh6ixuwtpfydmcsimldndemr2v4.ipfs.dweb.link/")
            }),
            scythe: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10017,
                held: 0,
                name: string::utf8(b"Scythe"),
                image_url:string::utf8(b"https://bafkreifigrglrdbtzjbgfwkpor3ezjw2x7jfpn4gvaokshuktmast3nw6a.ipfs.dweb.link/")
            }),
            acorn: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10000,
                held: 0,
                name: string::utf8(b"Acorn"),
                image_url: string::utf8(b"https://bafkreihhoqzanwbie5g6txegv5uiwnlp7ca5gnvmkmuqrxyyj2hkma54ly.ipfs.dweb.link/")
            }),
            parsnip_seed: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10006,
                held: 0,
                name: string::utf8(b"Parsnip Seed"),
                image_url: string::utf8(b"https://bafkreibmmduvgawjpjlo6h6usuudfwy6syivdewgvz666ljpplwojli5aq.ipfs.dweb.link/")
            }),
            pine: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10009,
                held: 0,
                name: string::utf8(b"Pine"),
                image_url: string::utf8(b"https://bafkreiaiz4mjx3uneh6bei2yih7bfzuc5vlsixulh3soxtrh2pqldspvu4.ipfs.dweb.link/")
            }),
            watering_can: option::some(Item {
                id: object::new(ctx),
                in_game_id: 10003,
                held: 0,
                name: string::utf8(b"Watering Can"),
                image_url: string::utf8(b"https://bafkreiezn4g476kojoomuoh7euuflhcwy3mxn4h7qow2fgxabkbgozpnwa.ipfs.dweb.link/")
            })
        }
    }

    // Entry function to update player's inventory
    public entry fun update_inventory(player: &mut Player, 
        pickaxe: u8, 
        axe: u8,
        basket: u8,
        corn: u8,
        parsnip: u8,
        pumpkin: u8,
        stone: u8,
        weed: u8,
        wood: u8,
        hoe: u8,
        scythe: u8,
        acorn: u8,
        parsnip_seed: u8,
        pine: u8,
        watering_can: u8)
    {
        // Unwrap the player's inventory
        let inventory = player.inventory.unwrap();
        // Update quantities of items in the inventory
        inventory.pickaxe.unwrap().held = pickaxe;
        inventory.axe.unwrap().held = axe;
        // Update quantities of other items similarly...
    }

    // Entry function to update player's experience points
    public entry fun update_player_xp(player: &mut Player, xp: u8)
    {
        // Update player's experience points
        player.xp = player.xp + xp;
    }
}







