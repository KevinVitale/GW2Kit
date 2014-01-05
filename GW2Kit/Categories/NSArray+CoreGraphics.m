//
//  NSArray+CoreGraphics.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/5/14.
//
//

#import "NSArray+CoreGraphics.h"

@implementation NSArray (CoreGraphics)
- (CGPoint)point:(NSInteger)precision {
    double x, y;
    double exponent = pow(10, precision);
    x = floor([self.firstObject doubleValue] * exponent + .5f) / exponent;
    y = floor([self.lastObject doubleValue] * exponent + .5f) / exponent;
    
    return CGPointMake(x, y);
}
- (CGSize)size:(NSInteger)precision {
    
    double width, height;
    double exponent = pow(10, precision);
    width = floor([self.firstObject doubleValue] * exponent + .5f) / exponent;
    height = floor([self.lastObject doubleValue] * exponent + .5f) / exponent;
    
    return CGSizeMake(width, height);
}
- (CGRect)rect:(NSInteger)precision {
    CGRect rect;
    rect.origin 	= [self.firstObject point:precision],
    rect.size 		= [self.lastObject size:precision];
    return rect;
}
@end