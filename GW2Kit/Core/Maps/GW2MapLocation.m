//
//  GW2MapLocation.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2MapLocation.h"

@implementation GW2MapLocation
+ (NSValueTransformer *)zRangeJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *zRangeDimensions) {
        CGSize size = CGSizeMake([[zRangeDimensions firstObject] integerValue],
                                 [[zRangeDimensions lastObject] integerValue]);
#if TARGET_OS_IPHONE
        return [NSValue valueWithCGSize:size];
#else
        return [NSValue valueWithSize:size];
#endif
    }
                                                         reverseBlock:^id (NSValue *sizeValue) {
#if TARGET_OS_IPHONE
                                                             CGSize size = [sizeValue CGSizeValue];
#else
                                                             CGSize size = (CGSize)[sizeValue sizeValue];
#endif
                                                             return @[@(size.width), @(size.height)];
                                                         }];
}
+ (NSValueTransformer *)pointsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *pointsArray) {
        NSMutableArray *pointsMutableArray = [NSMutableArray arrayWithCapacity:pointsArray.count];
        for(NSArray *coordinatesArray in pointsArray) {
            CGPoint point = CGPointMake([[coordinatesArray firstObject] floatValue],
                                        [[coordinatesArray lastObject] floatValue]);
#if TARGET_OS_IPHONE
            NSValue *pointValue = [NSValue valueWithCGPoint:point];
#else
            NSValue *pointValue = [NSValue valueWithPoint:point];
#endif
            [pointsMutableArray addObject:pointValue];
        }
        return [pointsMutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *pointsArray) {
                                                             NSMutableArray *pointsMutableArray = [NSMutableArray arrayWithCapacity:pointsArray.count];
                                                             for(NSValue *pointValue in pointsArray) {
#if TARGET_OS_IPHONE
                                                                 CGPoint point = [pointValue CGPointValue];
#else
                                                                 CGPoint point = (CGPoint)[pointValue pointValue];
#endif
                                                                 [pointsMutableArray addObject:@[@(point.x), @(point.y)]];
                                                             }
                                                             return [pointsMutableArray copy];
                                                         }
            ];
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
