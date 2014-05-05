//
//  GW2Skin.m
//
//
//  Created by Kevin Vitale on 4/20/14.
//
//

#import "GW2Object+Private.h"
#import "GW2Skin.h"


#pragma mark - Armor Skin, Interface
// -----------------------------------------------------------------------------
//  GW2ArmorSkin
// -----------------------------------------------------------------------------
@interface _GW2ArmorSkin : _GW2Object <GW2ArmorSkin>
@property (copy, nonatomic) NSString *slot;
@property (copy, nonatomic) NSString *weight;
@end

// -----------------------------------------------------------------------------
//  GW2ArmorSkin
// -----------------------------------------------------------------------------
@implementation _GW2ArmorSkin
// -----------------------------------------------------------------------------
//  JSONKeyPathsByPropertyKey
// -----------------------------------------------------------------------------
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return
    @{
      @"objectID" : NSNull.null,
      @"name"     : NSNull.null,
      @"slot"     : @"type",
      @"weight"   : @"weight_class",
      };
}
@end

#pragma mark - Weapon Skin, Interface
// -----------------------------------------------------------------------------
//  GW2WeaponSkin
// -----------------------------------------------------------------------------
@interface _GW2WeaponSkin : _GW2Object <GW2WeaponSkin>
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *element;
@end

// -----------------------------------------------------------------------------
//  GW2WeaponSkin
// -----------------------------------------------------------------------------
@implementation _GW2WeaponSkin
// -----------------------------------------------------------------------------
//  JSONKeyPathsByPropertyKey
// -----------------------------------------------------------------------------
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return
    @{
      @"objectID" : NSNull.null,
      @"name"     : NSNull.null,
      @"element"     : @"damage_type",
      };
}

@end

#pragma mark - Skin, Interface
// -----------------------------------------------------------------------------
//  GW2Skin
// -----------------------------------------------------------------------------
@interface _GW2Skin : _GW2Object <GW2Skin, GW2IconFile>
@property (copy, nonatomic) NSString        *optionalDescription;
@property (copy, nonatomic) NSString        *type;
@property (copy, nonatomic) NSArray         *flags;
@property (copy, nonatomic) NSArray         *restrictions;
@property (copy, nonatomic) NSString        *iconFileID;
@property (copy, nonatomic) NSString        *iconFileSignature;
@property (strong, nonatomic) id<GW2ArmorSkin>  armor;
@property (strong, nonatomic) id<GW2WeaponSkin> weapon;
@end

#pragma mark - Skin, Implementation
// -----------------------------------------------------------------------------
//  GW2Skin
// -----------------------------------------------------------------------------
@implementation _GW2Skin

// -----------------------------------------------------------------------------
//  JSONKeyPathsByPropertyKey
// -----------------------------------------------------------------------------
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths =
    [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID"             : @"skin_id",
        @"iconFileID"           : @"icon_file_id",
        @"iconFileSignature"    : @"icon_file_signature",
        @"optionalDescription"  : @"description",
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}

// -----------------------------------------------------------------------------
//  armorJSONTransformer
// -----------------------------------------------------------------------------
+ (NSValueTransformer *)armorJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:NSClassFromString(@"_GW2ArmorSkin")];
}

// -----------------------------------------------------------------------------
//  weaponJSONTransformer
// -----------------------------------------------------------------------------
+ (NSValueTransformer *)weaponJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:NSClassFromString(@"_GW2WeaponSkin")];
}



@end
