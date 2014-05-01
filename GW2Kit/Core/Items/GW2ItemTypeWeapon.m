//
//  GW2ItemTypeWeapon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/11/14.
//
//

#import "GW2ItemTypeWeapon.h"
#import "GW2Object+Private.h"

@interface _GW2ItemInfixUpgradeAttribute : _GW2Object <GW2ItemInfixUpgradeAttribute>
@property (copy, nonatomic, readwrite) NSString *attribute;
@property       (nonatomic, readwrite) NSInteger modifier;
@end

@implementation _GW2ItemInfixUpgradeAttribute

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"name"     : @"attribute",
        @"objectID" : @"modifier"
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end

@interface _GW2ItemInfixUpgrade : _GW2Object <GW2ItemInfixUpgrade>
@property (copy, nonatomic, readonly) NSArray *attributes;
@end
@implementation _GW2ItemInfixUpgrade
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"name"     : NSNull.null,
        @"objectID" : NSNull.null,
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
+ (NSValueTransformer *)attributesJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id (id attributesObject) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[attributesObject count]];
        for(NSDictionary *attribute in attributesObject) {
            if([attribute isKindOfClass:NSDictionary.class]) {
                [mutableArray addObject:[_GW2ItemInfixUpgradeAttribute objectWithID:nil
                                                                               name:nil
                                                                 fromJSONDictionary:attribute
                                                                              error:nil]];
            }
            else {
                if([attribute respondsToSelector:@selector(JSONRepresentation)]) {
                    [mutableArray addObject:[(_GW2ItemInfixUpgradeAttribute *)attribute JSONRepresentation]];
                }
            }
        }
        return [mutableArray copy];
    }];
}
@end

@interface _GW2ItemTypeWeapon : _GW2Object <GW2ItemType>
@property (copy, nonatomic, readonly) NSString  *type;
@property (copy, nonatomic, readonly) NSString  *damageType;
@property       (nonatomic, readonly) NSInteger minimumPower;
@property       (nonatomic, readonly) NSInteger maximumPower;
@property       (nonatomic, readonly) NSInteger defense;
@property (copy, nonatomic, readonly) NSArray   *infusionSlots;
@property       (nonatomic, readonly) NSInteger suffixItemID;
@property (nonatomic, readonly) id<GW2ItemInfixUpgrade> infixUpgrade;
@end

@implementation _GW2ItemTypeWeapon
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"name"            : @"type",
        @"damageType"      : @"damage_type",
        @"minimumPower"    : @"min_power",
        @"maximumPower"    : @"max_power",
        @"infusionSlots"   : @"infusion_slots",
        @"infixUpgrade"    : @"infix_upgrade",
        @"suffixItemID"    : @"suffix_item_id"
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
+ (NSValueTransformer *)infixUpgradeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id (id infixUpgrade) {
        id result;
        if([infixUpgrade isKindOfClass:NSDictionary.class]) {
            result = [_GW2ItemInfixUpgrade objectWithID:nil
                                                   name:nil
                                     fromJSONDictionary:infixUpgrade
                                                  error:nil];
        }
        else {
            result = [infixUpgrade JSONDictionary];
        }
        return result;
    }];
}
@end
