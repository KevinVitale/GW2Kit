//
//  GW2MapLocation.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2EventLocation.h"
#import "MTLValueTransformer+CoreGraphics.h"

@implementation GW2EventLocation
+ (NSValueTransformer *)zRangeJSONTransformer {
    return MTLReversibleSizeTransformer(0);
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"zRange"   : @"z_range",
        @"name"     : NSNull.null,
        @"objectID" : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
