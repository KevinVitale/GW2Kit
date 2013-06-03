//
//  GW2Color.m
//  GW2Kit
//
//  Created by Kevin Vitale on 6/1/13.
//
//

#import "GW2Color.h"
#import <RestKit/RestKit.h>
#import <UIKit/UIKit.h>

void hsl_to_hsv(float hh, float ss, float ll,
                float* h, float* s, float *v)
{
    *h = hh;
    ll *= 2;
    ss *= (ll <= 1) ? ll : 2 - ll;
    *v = (ll + ss) / 2;
    *s = (2 * ss) / (ll + ss);
}

void hsv_to_hsl(float h, float s, float v,
                float* hh, float* ss, float *ll)
{
    *hh = h;
    *ll = (2 - s) * v;
    *ss = s * v;
    *ss /= (*ll <= 1) ? (*ll) : 2 - (*ll);
    *ll /= 2;
}

@interface GW2Color ()
@property (copy, nonatomic) NSDictionary *defaultColorDict;
@property (copy, nonatomic) NSDictionary *clothColorDict;
@property (copy, nonatomic) NSDictionary *leatherColorDict;
@property (copy, nonatomic) NSDictionary *metalColorDict;
- (id)colorForComponents:(NSDictionary *)components;
@end

@implementation GW2Color
@dynamic defaultColor;
@dynamic clothColor;
@dynamic leatherColor;
@dynamic metalColor;

+ (NSDictionary *)mappingAttributes {
    return @{
             @"(id).name"    : @"name",
             @"(id).default" : @"defaultColorDict",
             @"(id).cloth"   : @"clothColorDict",
             @"(id).leather" : @"leatherColorDict",
             @"(id).metal"   : @"metalColorDict",
             };
}
+ (RKMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class] ];
    mapping.forceCollectionMapping = YES;
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"id"];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    
    return mapping;
}

- (id)colorForComponents:(NSDictionary *)components {
    if(!components) {
        return nil;
    }
    
    // 0. Get the brightness  & contrast values (normalizing values...we assume 255.f)
    float brightness = [components[@"brightness"] floatValue];
    float contrast = [components[@"contrast"] floatValue];
    
    // 1a. Take the base color (RGB normalized in 255.f)
    float base_RedComponent     = 128.f;
    float base_GreenComponent   = 26.f;
    float base_BlueComponent    = 26.f;
    
    // 1b. Apply brightness
    base_RedComponent += brightness;
    base_GreenComponent += brightness;
    base_BlueComponent += brightness;
    
    // 1c. Apply contrast
    base_RedComponent = (base_RedComponent - 128.f) * contrast + 128.f;
    base_GreenComponent = (base_GreenComponent - 128.f) * contrast + 128.f;
    base_BlueComponent = (base_BlueComponent - 128.f) * contrast + 128.f;
    
    UIColor *baseColor = [UIColor colorWithRed:(base_RedComponent / 255.f)
                                         green:(base_GreenComponent / 255.f)
                                          blue:(base_BlueComponent / 255.f)
                                         alpha:1.f];
    
    // 2a. Convert from RGB to HSV
    float hsv_Hue, hsv_Sat, hsv_Bright;
    [baseColor getHue:&hsv_Hue
           saturation:&hsv_Sat
           brightness:&hsv_Bright
                alpha:NULL];
    
    // 2b. Convert form HSV to HSL
    float hsl_Hue, hsl_Sat, hsl_Light;
    hsv_to_hsl(hsv_Hue, hsv_Sat, hsv_Bright,
               &hsl_Hue,
               &hsl_Sat,
               &hsl_Light);
    
    // 3a. Normalize HSL values from response
    float hue           = [components[@"hue"] floatValue] / 360.f;
    float saturation    = [components[@"saturation"] floatValue];
    float lightness     = [components[@"lightness"] floatValue];
    
    // 3b. Apply HSL shifts
    hsl_Hue     *= hue;
    hsl_Sat     *= saturation;
    hsl_Light   *= lightness;
    
    hsl_to_hsv(hsl_Hue, hsl_Sat, hsl_Light,
               &hsv_Hue, &hsv_Sat, &hsv_Bright);
    
    UIColor *color = [UIColor colorWithHue:hsv_Hue
                                saturation:hsv_Sat
                                brightness:hsv_Bright
                                     alpha:1.f];
    return color;
}
- (id)defaultColor {
    return [self colorForComponents:self.defaultColorDict];
}
- (id)clothColor {
    return [self colorForComponents:self.clothColorDict];
}
- (id)leatherColor {
    return [self colorForComponents:self.leatherColorDict];
}
- (id)metalColor {
    return [self colorForComponents:self.metalColorDict];
}

- (NSString *)description {
    
    return [@{@"Name": self.name, @"ID:" : self.id, @"Default" : self.defaultColor, @"Cloth" : self.clothColor, @"Leather" : self.leatherColor, @"Metal" : self.metalColor} description];
}
@end
