//
//  MTLValueTransformer+NSArray.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/5/14.
//
//

#import "MTLValueTransformer.h"
#import "MTLValueTransformer+CoreGraphics.h"
#import "NSArray+CoreGraphics.h"

MTLValueTransformer* MTLReversibleSizeTransformer(NSInteger precision) {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *sizeArray) {
        CGSize size = [sizeArray size:precision];
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

MTLValueTransformer* MTLReversiblePointTransformer(NSInteger precision) {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *pointArray) {
        CGPoint point = [pointArray point:precision];
#if TARGET_OS_IPHONE
        NSValue *pointValue = [NSValue valueWithCGPoint:point];
#else
        NSValue *pointValue = [NSValue valueWithPoint:point];
#endif
        return pointValue;
    }
                                                         reverseBlock:^id (NSValue *pointValue) {
#if TARGET_OS_IPHONE
                                                             CGPoint point = [pointValue CGPointValue];
#else
                                                             CGPoint point = (CGPoint)[pointValue pointValue];
#endif
                                                             return @[@(point.x), @(point.y)];
    }];
}

MTLValueTransformer* MTLReversibleRectTransformer(NSInteger precision) {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *rectArray) {
        CGRect rect = [rectArray rect:precision];
#if TARGET_OS_IPHONE
        NSValue *rectValue = [NSValue valueWithCGRect:rect];
#else
        NSValue *rectValue = [NSValue valueWithRect:rect];
#endif
        return rectValue;
    }
                                                         reverseBlock:^id (NSValue *rectValue) {
#if TARGET_OS_IPHONE
                                                             CGRect rect = [rectValue CGRectValue];
#else
                                                             CGRect rect = (CGRect)[rectValue rectValue];
#endif
                                                             return @[ @[ @(rect.origin.x),     @(rect.origin.y) ],
                                                                       @[ @(rect.size.width),   @(rect.size.height) ]
                                                                    ];
                                                         }];
}