module suifarm::game {
    use sui::coin::{Self, Coin};
    use sui::event;
    use sui::object::{Self, ID, UID};
    use sui::math;
    use sui::sui::SUI;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option::{Self, Option};
    use std::string::{Self, String};

    struct PlayerData has key, store {
        id: UID,
        xp: u8,
        inventory: Option<InventoryData>
    }

    struct InventoryData has key, store {
        id: UID,
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

    struct Item has key, store {
        id: UID,
        in_game_id: u16,
        held: u8,
        name: string::String,
        image_url: string::String,
    }

    impl InventoryData {
        fn unwrap(&self) -> &InventoryData {
            match &self.inventory {
                Some(inventory) => inventory,
                None => panic!("Called `InventoryData::unwrap()` on a `None` value"),
            }
        }
    }

    public entry fun create_player(xp: u8, ctx: &mut TxContext) {
        let inventory = create_new_inventory(ctx);
        transfer::transfer(PlayerData {
            id: object::new(ctx),
            xp: xp,
            inventory: option::some(inventory)
        }, tx_context::sender(ctx));
    }

    fun create_new_inventory(ctx: &mut TxContext): InventoryData {
        InventoryData {
            id: object::new(ctx),
            pickaxe: create_item(ctx, 10013, "Pickaxe", "https://bafkreicpi5dtcswo7e3dvly2upwzjse3k3dy6q3gycwfjm434nmh4bfiri.ipfs.dweb.link/"),
            axe: create_item(ctx, 10005, "Axe", "https://bafkreielbw2mux3vptrzuougyt7bt4ctwgyw6igfnlnhsh6yvoz3avndem.ipfs.dweb.link/"),
            basket: create_item(ctx, 10012, "Basket", "https://bafkreiaty23ypd5cjlvtmdbpngbnmvtiyltqzvctplbznfyyiwvmjhamqu.ipfs.dweb.link/"),
            corn: create_item(ctx, 10002, "Corn", "https://bafkreifltsjqnye4l7wkptdvjnaz6od5ogn6vwrytumm3glgm7fcm33jrq.ipfs.dweb.link/"),
            parsnip: create_item(ctx, 10007, "Parsnip", "https://bafkreia4mcrcfr6iwcrhsah57ywerws5wi7gamxj7b523qi35g5logjagy.ipfs.dweb.link/"),
            pumpkin: create_item(ctx, 10001, "Pumpkin", "https://bafkreiga5iz5vmdkvgzq375ntcbs4jziyv5symfz6skmd4wtuvv36njlh4.ipfs.dweb.link/"),
            stone: create_item(ctx, 10015, "Stone", "https://bafkreiehvy5d4h5xh6doiaxsss5vecbixd7ll6dcfbdolojyjtqwxzsh54.ipfs.dweb.link/"),
            weed: create_item(ctx, 10020, "Weed", "https://bafkreihwayy5uko53ffhganvhfczgom7vv7wcymzfhltt77ixwsqmnkjvm.ipfs.dweb.link/"),
            wood: create_item(ctx, 10008, "Wood", "https://bafkreifpgtzqvighooclv5p3czwqj7lutnoeup23oi5buoqwg7v5zhntqm.ipfs.dweb.link/"),
            hoe: create_item(ctx, 10004, "Hoe", "https://bafkreibraxpnocidllmhriknwuuy6whyh6ixuwtpfydmcsimldndemr2v4.ipfs.dweb.link/"),
            scythe: create_item(ctx, 10017, "Scythe", "https://bafkreifigrglrdbtzjbgfwkpor3ezjw2x7jfpn4gvaokshuktmast3nw6a.ipfs.dweb.link/"),
            acorn: create_item(ctx, 10000, "Acorn", "https://bafkreihhoqzanwbie5g6txegv5uiwnlp7ca5gnvmkmuqrxyyj2hkma54ly.ipfs.dweb.link/"),
            parsnip_seed: create_item(ctx, 10006, "Parsnip Seed", "https://bafkreibmmduvgawjpjlo6h6usuudfwy6syivdewgvz666ljpplwojli5aq.ipfs.dweb.link/"),
            pine: create_item(ctx, 10009, "Pine", "https://bafkreiaiz4mjx3uneh6bei2yih7bfzuc5vlsixulh3soxtrh2pqldspvu4.ipfs.dweb.link/"),
            watering_can: create_item(ctx, 10003, "Watering Can", "https://bafkreiezn4g476kojoomuoh7euuflhcwy3mxn4h7qow2fgxabkbgozpnwa.ipfs.dweb.link/")
        }
    }

    fun create_item(ctx: &mut TxContext, in_game_id: u16, name: &str, image_url: &str) -> Option<Item> {
        option::some(Item {
            id: object::new(ctx),
            in_game_id,
            held: 0,
            name: string::utf8(name.as_bytes()),
            image_url: string::utf8(image_url.as_bytes())
        })
    }

    public entry fun update_inventory(player: &mut PlayerData, 
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
        watering_can: u8) {
        let inventory = player.inventory.unwrap();
        inventory.pickaxe.unwrap().held = pickaxe;
        inventory.axe.unwrap().held = axe;
        inventory.basket.unwrap().held = basket;
        inventory.corn.unwrap().held = corn;
        inventory.parsnip.unwrap().held = parsnip;
        inventory.pumpkin.unwrap().held = pumpkin;
        inventory.stone.unwrap().held = stone;
        inventory.weed.unwrap().held = weed;
        inventory.wood.unwrap().held = wood;
        inventory.hoe.unwrap().held = hoe;
        inventory.scythe.unwrap().held = scythe;
        inventory.acorn.unwrap().held = acorn;
        inventory.parsnip_seed.unwrap().held = parsnip_seed;
        inventory.pine.unwrap().held = pine;
        inventory.watering_can.unwrap().held = watering_can;
    }

    public entry fun update_player_xp(player: &mut PlayerData, xp: u8) {
        player.xp = player.xp + xp;
    }
}
