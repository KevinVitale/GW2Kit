//
//  GW2EventDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 6/24/13.
//
//

#import "GW2EventDetail.h"
#import <RestKit/RestKit.h>

@implementation GW2EventLocation
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
    return @{@"type"     : @"type",
             @"center"   : @"centerPosition",
             @"radius"   : @"radius",
             @"rotation" : @"rotation",
             @"z_range"  : @"z_range",
             @"points"   : @"points",};
}

+ (RKMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    [mapping setSetDefaultValueForMissingAttributes:YES];
    return mapping;
}

@end

@implementation GW2EventDetail
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
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"id"];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    mapping.forceCollectionMapping = YES;
    [mapping addPropertyMappingsFromArray:@[
                                            [RKRelationshipMapping relationshipMappingFromKeyPath:@"(id).location"
                                                                                        toKeyPath:@"location"
                                                                                      withMapping:[GW2EventLocation mappingObject]]
                                            ]];
    return mapping;
}
+ (NSDictionary *)mappingAttributes {
    return @{
             @"(id).name" : @"name",
             @"(id).level" : @"level",
             @"(id).map_id" : @"mapID",
             @"(id).flags" : @"flags",
             };
}
@end
