//
//  GW2GuildDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 6/3/13.
//
//

#import "GW2GuildDetail.h"
#import <RestKit/RestKit.h>

@implementation GW2Emblem : NSObject
- (NSString *)description {
    NSUInteger stringLength = 0;
    NSMutableString *description = [NSMutableString stringWithString:@"\n"];
    for(RKPropertyMapping *property in [[[self class] mappingObject] propertyMappings]) {
        NSString *attribute = [property destinationKeyPath];
        NSString *string = [NSString stringWithFormat:@"  %@: %@\n", [attribute stringByPaddingToLength:40
                                                                                             withString:@" "
                                                                                        startingAtIndex:0], [self valueForKey:attribute]];
        [description appendString:string];
        stringLength = (stringLength < string.length ? string.length : stringLength);
    }
    
    return description;
}
+ (NSDictionary *)mappingAttributes {
    return @{
             @"background_id": @"backgroundImageID",
             @"foreground_id": @"foregroundImageID",
             @"flags": @"flags",
             @"background_color_id": @"backgroundColorID",
             @"foreground_primary_color_id": @"foregroundPrimaryColorID",
             @"foreground_secondary_color_id": @"foregroundSecondaryColorID"
             };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}
@end

@implementation GW2GuildDetail
- (NSString *)description {
    NSUInteger stringLength = 0;
    NSMutableString *description = [NSMutableString stringWithString:@"\n"];
    for(RKPropertyMapping *property in [[[self class] mappingObject] propertyMappings]) {
        NSString *attribute = [property destinationKeyPath];
        NSString *string = [NSString stringWithFormat:@"  %@: %@\n", [attribute stringByPaddingToLength:40
                                                                                             withString:@" "
                                                                                        startingAtIndex:0], [self valueForKey:attribute]];
        [description appendString:string];
        stringLength = (stringLength < string.length ? string.length : stringLength);
    }
    
    return description;
}

+ (NSDictionary *)mappingAttributes {
    return @{
             @"guild_id":   @"id",
             @"guild_name": @"name",
             @"tag":        @"tag",
             };
}

+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"emblem" mapping:[GW2Emblem mappingObject]];
    return mapping;
}
@end
