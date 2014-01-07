//
//  GW2MapLocation.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2EventLocation.h"
#import "NSArray+CoreGraphics.h"
#import "MTLValueTransformer+CoreGraphics.h"

@implementation GW2EventLocation
+ (NSValueTransformer *)zRangeJSONTransformer {
    return MTLReversibleSizeTransformer(0);
}

+ (NSValueTransformer *)pointsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *pointsArray) {
        NSMutableArray *mutableValueArray = [NSMutableArray arrayWithCapacity:pointsArray.count];
        for(NSArray *pointArray in pointsArray) {
            CGPoint point = [pointArray point:1];
#if TARGET_OS_IPHONE
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
#else
            NSValue *pointValue = [NSValue valueWithPoint:point];
#endif
            [mutableValueArray addObject:pointValue];
        }
        return [mutableValueArray copy];
    }
                                                         reverseBlock:^id (NSArray *valueArray) {
                                                             NSMutableArray *mutablePointsArray = [NSMutableArray arrayWithCapacity:valueArray.count];
                                                             for(NSValue *pointValue in valueArray) {
#if TARGET_OS_IPHONE
                                                                 CGPoint point = [pointValue CGPointValue];
#else
                                                                 CGPoint point = (CGPoint)[pointValue pointValue];
#endif
                                                                 [mutablePointsArray addObject:@[@(point.x), @(point.y)]];
                                                             }
                                                             return [mutablePointsArray copy];
                                                         }];
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
