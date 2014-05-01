//
//  GW2Color.h
//  GW2Kit
//
//  Created by Kevin Vitale on 6/1/13.
//
//

#import "GW2Object.h"

#if TARGET_OS_IPHONE
@import CoreGraphics;
#endif

@protocol GW2ColorMaterial <GW2Object>
@property (nonatomic, readonly) NSInteger   brightness;
@property (nonatomic, readonly) CGFloat     contrast;
@property (nonatomic, readonly) NSInteger   hue;
@property (nonatomic, readonly) CGFloat     saturation;
@property (nonatomic, readonly) CGFloat     lightness;
@property (copy, readonly, nonatomic) id    color;
@end

@protocol GW2Color <GW2Object>
@property (copy, readonly, nonatomic) id color;
@property (readonly, nonatomic) id<GW2ColorMaterial> cloth;
@property (readonly, nonatomic) id<GW2ColorMaterial> leather;
@property (readonly, nonatomic) id<GW2ColorMaterial> metal;
@end