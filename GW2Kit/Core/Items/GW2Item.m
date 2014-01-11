//
//  GW2Item.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/9/14.
//
//

#import "GW2Item.h"
#import "GW2Object+Private.h"

@interface GW2Item : _GW2Object <GW2Item>
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
@property       (nonatomic, readonly) GW2ItemType *itemType;
@end

@interface GW2ItemType : _GW2Object <GW2ItemType>
@property (copy, nonatomic, readonly) NSString  *type;
@property (copy, nonatomic, readonly) NSString  *damageType;
@property       (nonatomic, readonly) NSInteger minimumPower;
@property       (nonatomic, readonly) NSInteger maximumPower;
@property       (nonatomic, readonly) NSInteger defense;
@property (copy, nonatomic, readonly) NSArray   *infusionSlots;
@property (nonatomic, readonly) id<GW2ItemInfixUpgrade> infixUpgrade;
@end

//------------------------------------------------------------------------------
@interface _GW2ItemInfixUpgradeAttribute : _GW2Object
@property (copy, nonatomic, readwrite) NSString *attribute;
@property       (nonatomic, readwrite) NSInteger modifier;
@end

@implementation _GW2ItemInfixUpgradeAttribute
@dynamic attribute, modifier;

- (NSString *)attribute {
    return self.name;
}
- (NSInteger)modifier {
    return [self.objectID integerValue];
}

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
//------------------------------------------------------------------------------

@interface GW2Item ()
@end
@implementation GW2Item
+ (NSValueTransformer *)objectIDJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id (id objectID) {
        id result;
        if([objectID isKindOfClass:NSString.class]) {
            result = @([objectID integerValue]);
        }
        else if([objectID isKindOfClass:NSNumber.class]) {
            result = [objectID stringValue];
        }
        return result;
    }];
}
+ (NSValueTransformer *)vendorValueJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id (id objectID) {
        id result;
        if([objectID isKindOfClass:NSString.class]) {
            result = @([objectID integerValue]);
        }
        else if([objectID isKindOfClass:NSNumber.class]) {
            result = [objectID stringValue];
        }
        return result;
    }];
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID" : @"item_id",
        @"iconFileID" : @"icon_file_id",
        @"iconFileSignature" : @"icon_file_signature",
        @"gameTypes" : @"game_types",
        @"suffixItemID" : @"suffix_item_id",
        @"vendorValue" : @"vendor_value"
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
