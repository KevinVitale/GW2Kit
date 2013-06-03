//
//  GW2Build.m
//  GW2Kit
//
//  Created by Kevin Vitale on 6/1/13.
//
//

#import "GW2Build.h"
#import <RestKit/RestKit.h>

@implementation GW2Build
+ (NSDictionary *)mappingAttributes {
    return @{
             @"build_id": @"buildID"
             };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}
@end
