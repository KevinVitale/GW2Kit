//
//  GW2Color.h
//  GW2Kit
//
//  Created by Kevin Vitale on 6/1/13.
//
//

#import <Foundation/Foundation.h>

@class RKMapping;

@interface GW2ColorMaterial : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *brightness;
@property (copy, nonatomic) NSNumber *contrast;
@property (copy, nonatomic) NSNumber *hue;
@property (copy, nonatomic) NSNumber *saturation;
@property (copy, nonatomic) NSNumber *lightness;
@property (copy, nonatomic) NSArray  *rgb;

- (id)color;
+ (RKMapping *)mappingObject;
@end


@interface GW2Color : NSObject
@property (copy, readonly, nonatomic) NSString *id;
@property (copy, readonly, nonatomic) NSString *name;
@property (copy, readonly, nonatomic) NSArray  *base_rgb;
@property (strong, readonly, nonatomic) GW2ColorMaterial *clothMaterial;
@property (strong, readonly, nonatomic) GW2ColorMaterial *leatherMaterial;
@property (strong, readonly, nonatomic) GW2ColorMaterial *metalMaterial;

+ (RKMapping *)mappingObject;
@end
