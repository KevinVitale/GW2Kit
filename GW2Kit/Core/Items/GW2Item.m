//
//  GW2Item.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/9/14.
//
//

#import "GW2Item+Private.h"

@implementation _GW2Item
/**
 *  Transforms 'item_id' to 'itemID'.
 *
 *  @return A new value transformer.
 *  @note The input comes in as NSString; the output as an NSNumber.
 */
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

/**
 *  Transforms 'vendor_value' to 'vendorValue'.
 *
 *  @return A new value transformer. 
 *  @note The input comes in as NSString; the output as an NSNumber.
 */
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
        @"objectID"             : @"item_id",
        @"iconFileID"           : @"icon_file_id",
        @"iconFileSignature"    : @"icon_file_signature",
        @"gameTypes"            : @"game_types",
        @"suffixItemID"         : @"suffix_item_id",
        @"vendorValue"          : @"vendor_value",
        @"weapon"               : @"weapon",
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
