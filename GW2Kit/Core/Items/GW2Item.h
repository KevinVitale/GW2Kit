//
//  GW2Item.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/9/14.
//
//

#import "GW2Object.h"

@protocol GW2ItemInfixUpgrade <NSObject>
@required
@property (copy, nonatomic, readonly) NSArray *attributes;
@end

@protocol GW2ItemInfixUpgradeAttribute <NSObject>
@property (copy, nonatomic, readonly) NSString *attirbutes;
@property       (nonatomic, readonly) NSInteger modifier;
@end

@protocol GW2ItemType <GW2Object>
@property (copy, nonatomic, readonly) NSString  *type;
@property (copy, nonatomic, readonly) NSString  *damageType;
@property       (nonatomic, readonly) NSInteger minimumPower;
@property       (nonatomic, readonly) NSInteger maximumPower;
@property       (nonatomic, readonly) NSInteger defense;
@property (copy, nonatomic, readonly) NSArray   *infusionSlots;
@property (nonatomic, readonly) id<GW2ItemInfixUpgrade> infixUpgrade;
@end

@protocol GW2Item <GW2Object>
@property (copy, nonatomic, readonly) NSString  *description;
@property (copy, nonatomic, readonly) NSString  *type;
@property (copy, nonatomic, readonly) NSString  *rarity;
@property (copy, nonatomic, readonly) NSArray   *gameTypes;
@property (copy, nonatomic, readonly) NSArray   *flags;
@property (copy, nonatomic, readonly) NSArray   *restrictions;
@property (copy, nonatomic, readonly) NSString  *iconFileSignature;
@property       (nonatomic, readonly) NSInteger iconFileID;
@property       (nonatomic, readonly) NSInteger level;
@property       (nonatomic, readonly) NSInteger vendorValue;
@property       (nonatomic, readonly) NSInteger suffixItemID;
@property       (nonatomic, readonly) id<GW2ItemType> itemType;
@end
