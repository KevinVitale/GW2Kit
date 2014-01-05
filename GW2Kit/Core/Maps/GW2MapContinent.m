//
//  GW2MapContinent.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2MapContinent.h"
#import "MTLValueTransformer+CoreGraphics.h"

@implementation GW2MapContinent
+ (NSValueTransformer *)sizeJSONTransformer {
    return MTLReversibleSizeTransformer(0);
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"size"     : @"continent_dims",
        @"minZoom"  : @"min_zoom",
        @"maxZoom"  : @"max_zoom",
        @"objectID" : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
