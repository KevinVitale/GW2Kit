//
//  GW2ItemDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;
@class RKMapping;

@interface GW2ItemDetail : NSObject
@property (copy, nonatomic) NSString *itemID;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *level;
@property (copy, nonatomic) NSString *rarity;
@property (copy, nonatomic) NSString *vendorValue;
@property (copy, nonatomic) NSArray *gameTypes;
@property (copy, nonatomic) NSArray *flags;
@property (copy, nonatomic) NSArray *restrictions;
@property (strong, nonatomic) id info;

+ (NSDictionary *)mappingAttributes;
+ (RKMapping *)mappingObject;
@end


/*
@interface GW2WeaponInfo : NSObject
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *damageType;
@property (copy, nonatomic) NSString *minPower;
@property (copy, nonatomic) NSString *maxPower;
@property (copy, nonatomic) NSString *defense;
@property (copy, nonatomic) NSArray *infusionSlots;
@property (copy, nonatomic) NSDictionary *infixUpgrade;
@property (copy, nonatomic) NSString *suffixItemID;
@property (weak, nonatomic) GW2ItemDetail *item;

+ (NSDictionary *)mappingAttributes;
+ (RKObjectMapping *)mappingObject;
@end


@interface GW2ConsumableInfo : NSObject
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSNumber *duration;
@property (copy, nonatomic) NSString *detail;

+ (NSDictionary *)mappingAttributes;
+ (RKObjectMapping *)mappingObject;
@end
 */