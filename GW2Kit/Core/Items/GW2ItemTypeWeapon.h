//
//  GW2ItemTypeWeapon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/11/14.
//
//

#import "GW2Item.h"

/**
 *  Infix upgrades. It has a single property: 'attributes'.
 */
@protocol GW2ItemInfixUpgrade <NSObject>
@required
/**
 *  A list of attributes (see GW2ItemInfixUpgradeAttribute)
 */
@property (copy, nonatomic, readonly) NSArray *attributes;
@end

/**
 *  An infix upgrade attribute.
 */
@protocol GW2ItemInfixUpgradeAttribute <NSObject>
/**
 *  The type of attribute:
 *    - Power
 *    - Precision
 *    - Toughness
 *    - Vitality
 *    - Condition Damage
 *    - Condition Duration
 *    - Boon Duration
 *    - Healing Power
 *    - Critical Damage
 */
@property (copy, nonatomic, readonly) NSString *attribute;

/**
 *  The amount by which the attribute modifies its value.
 */
@property       (nonatomic, readonly) NSInteger modifier;
@end

/**
 *  An item type (wholly belonging to an item).
 */
@protocol GW2ItemTypeWeapon <GW2ItemType>

/**
 *  For weapons, possible values are:
 *    - Axe
 *    - Dagger
 *    - Focus
 *    - Greatsword
 *    - Hammer
 *    - Harpoon
 *    - LongBow
 *    - Mace
 *    - Pistol
 *    - Rifle
 *    - Scepter
 *    - Shield
 *    - ShortBow
 *    - Speargun
 *    - Sword
 *    - Staff
 *    - Torch
 *    - Trident
 *    - Warhorn
 */
@property (copy, nonatomic, readonly) NSString  *type;

/**
 *  The amount by which the item does damage (Weapon only).
 */
@property (copy, nonatomic, readonly) NSString  *damageType;

/**
 *  Minimum power (Weapon only).
 */
@property       (nonatomic, readonly) NSInteger minimumPower;

/**
 *  Maximum power (Weapon only).
 */
@property       (nonatomic, readonly) NSInteger maximumPower;

/**
 *  Item's defense value.
 */
@property       (nonatomic, readonly) NSInteger defense;

/**
 *  Number of infusion slots the item has (Ascended only).
 */
@property (copy, nonatomic, readonly) NSArray   *infusionSlots;

/**
 *  The item's infix upgrade information. (see GW2ItemInfixUpgrade)
 */
@property (nonatomic, readonly) id<GW2ItemInfixUpgrade> infixUpgrade;

/**
 *  The item id of an already applied upgrade component. Can be empty
 */
@property       (nonatomic, readonly) NSInteger suffixItemID;
@end
