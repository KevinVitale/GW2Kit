//
//  GW2Item.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/9/14.
//
//

#import "GW2Object.h"

/**
 *  The base protocol for all item types.
 */
@protocol GW2ItemType <GW2Object>
@required
/**
 *  All item types have their owen type.
 */
@property (copy, nonatomic, readonly) NSString *type;
@end

/**
 *  The interface for an item returned by the API's 'item_details' response.
 */
@protocol GW2Item <GW2Object>
@property (copy, nonatomic, readonly) NSString  *description;

/**
 *  The item type:
 *    - Armor
 *    - Bag
 *    - Consumable
 *    - Container
 *    - CraftingMaterial
 *    - Gizmo
 *    - MiniPet
 *    - Trinket
 *    - Trophy
 *    - UpgradeComponent
 *    - Weapon
 */
@property (copy, nonatomic, readonly) NSString  *type;

/**
 *  The item rarity:
 *    - Basic
 *    - Fine
 *    - Masterwork
 *    - Rare
 *    - Exotic
 *    - Ascended
 *    - Legendary
 */
@property (copy, nonatomic, readonly) NSString  *rarity;

/**
 *  Game types which the weapon can be used in (includes at least 1):
 *    - Activity
 *    - Dungeon
 *    - Pve
 *    - PvP
 *    - PvPLobby
 *    - WvW
 */
@property (copy, nonatomic, readonly) NSArray   *gameTypes;

/**
 *  Any number of additional flags:
 *    - AccountBound
 *    - HideSuffix
 *    - NoMysticForge
 *    - NoSell
 *    - NoSalvage
 *    - NotUpgradable
 *    - NoUnderwater
 *    - SoulbindOnAcquire
 *    - SoulBindOnUse
 *    - Unique
 */
@property (copy, nonatomic, readonly) NSArray   *flags;

/**
 *  Item usage restrictions based on character race:
 *    - Asura
 *    - Human
 *    - Charr
 *    - Norn
 */
@property (copy, nonatomic, readonly) NSArray   *restrictions;

/**
 *  Icon file signature.
 */
@property (copy, nonatomic, readonly) NSString  *iconFileSignature;

/**
 *  Icon file ID.
 */
@property       (nonatomic, readonly) NSInteger iconFileID;

/**
 *  The item's required level.
 */
@property       (nonatomic, readonly) NSInteger level;

/**
 *  The sell value of an item to a vendor.
 */
@property       (nonatomic, readonly) NSInteger vendorValue;


/**
 *  Item type. Matches the 'type'.
 */
@property       (nonatomic, readonly) id<GW2ItemType> itemType;
@end
