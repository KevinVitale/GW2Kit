//
//  GW2Color.m
//  GW2Kit
//
//  Created by Kevin Vitale on 6/1/13.
//
//

#import "GW2Color.h"
#if TARGET_OS_IPHONE
@import UIKit.UIColor;
#else
@import AppKit;
#endif

@interface GW2Color ()

@end

@implementation GW2Color
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"color"    : @"base_rgb",
        @"objectID" : NSNull.null,
    };
}
+ (NSValueTransformer *)clothJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GW2ColorMaterial.class];
}
+ (NSValueTransformer *)leatherJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GW2ColorMaterial.class];
}
+ (NSValueTransformer *)metalJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GW2ColorMaterial.class];
}
+ (NSValueTransformer *)colorJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *rgbArray) {
        id color;
        if(rgbArray.count == 3) {
            CGFloat red     = [rgbArray[0] floatValue] / 255.f;
            CGFloat green   = [rgbArray[1] floatValue] / 255.f;
            CGFloat blue    = [rgbArray[2] floatValue] / 255.f;
#if TARGET_OS_IPHONE
            color = [UIColor colorWithRed:red
                                    green:green
                                     blue:blue
                                    alpha:1.f];
#else
            color = [NSColor colorWithRed:red
                                    green:green
                                     blue:blue
                                    alpha:1.f];
#endif
        }
        return color;
    }
                                                         reverseBlock:^id (id color) {
#if TARGET_OS_IPHONE
                                                             CGFloat red, green, blue;
                                                             [color getRed:&red
                                                                     green:&green
                                                                      blue:&blue
                                                                     alpha:NULL];
#else
                                                             CGFloat red     = [color redComponent];
                                                             CGFloat green   = [color greenComponent];
                                                             CGFloat blue    = [color blueComponent];
#endif
                                                             return @[
                                                                      @((NSUInteger)(red * 255.f)),
                                                                      @((NSUInteger)(green * 255.f)),
                                                                      @((NSUInteger)(blue * 255.f))
                                                                      ];
                                                         }];
}
@end


@implementation GW2ColorMaterial
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"color"    : @"rgb",
        @"objectID" : NSNull.null,
        @"name"     : NSNull.null
    };
}
+ (NSValueTransformer *)colorJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *rgbArray) {
        id color;
        if(rgbArray.count == 3) {
            CGFloat red     = [rgbArray[0] floatValue] / 255.f;
            CGFloat green   = [rgbArray[1] floatValue] / 255.f;
            CGFloat blue    = [rgbArray[2] floatValue] / 255.f;
#if TARGET_OS_IPHONE
            color = [UIColor colorWithRed:red
                                    green:green
                                     blue:blue
                                    alpha:1.f];
#else
            color = [NSColor colorWithRed:red
                                    green:green
                                     blue:blue
                                    alpha:1.f];
#endif
        }
        return color;
    }
                                                         reverseBlock:^id (id color) {
#if TARGET_OS_IPHONE
                                                             CGFloat red, green, blue;
                                                             [color getRed:&red
                                                                     green:&green
                                                                      blue:&blue
                                                                     alpha:NULL];
#else
                                                             CGFloat red     = [color redComponent];
                                                             CGFloat green   = [color greenComponent];
                                                             CGFloat blue    = [color blueComponent];
#endif
                                                             return @[
                                                                      @((NSUInteger)(red * 255.f)),
                                                                      @((NSUInteger)(green * 255.f)),
                                                                      @((NSUInteger)(blue * 255.f))
                                                                      ];
                                                         }];
}
@end