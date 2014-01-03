//
//  GW2MapContinent.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2MapContinent.h"

@implementation GW2MapContinent
+ (NSValueTransformer *)sizeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *continentDimensions) {
        CGSize size = CGSizeMake([[continentDimensions firstObject] integerValue],
                                 [[continentDimensions lastObject] integerValue]);
#if TARGET_OS_IPHONE
        return [NSValue valueWithCGSize:size];
#else
        return [NSValue valueWithSize:size];
#endif
    }
                                                         reverseBlock:^id (NSValue *size) {
#if TARGET_OS_IPHONE
                                                             CGSize sizeValue = [size CGSizeValue];
#else
                                                             CGSize sizeValue = (CGSize)[size sizeValue];
#endif
                                                             return @[@(sizeValue.width), @(sizeValue.height)];
                                                         }];
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
