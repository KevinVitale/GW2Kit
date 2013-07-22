//
//  GW2MapFloorResponse.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import "GW2MapFloorResponse.h"
#import <RestKit/RestKit.h>


@implementation GW2BaseMapResource
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
    return nil;
}
@end

@implementation GW2MapFloorPointOfInterest
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping setSetNilForMissingRelationships:YES];
    [mapping addAttributeMappingsFromArray:@[@"poi_id", @"name", @"type", @"floor", @"coord"]];
    
    return mapping;
}
@end

@implementation GW2MapFloorDetail
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"id"];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    [mapping addPropertyMappingsFromArray:@[
                                            [RKRelationshipMapping relationshipMappingFromKeyPath:@"(id).points_of_interest"
                                                                                        toKeyPath:@"points_of_interest"
                                                                                      withMapping:[GW2MapFloorPointOfInterest mappingObject]]
                                            ]];
    mapping.forceCollectionMapping = YES;
    
    return mapping;
}

+ (NSDictionary *)mappingAttributes {
    
    return @{
             @"(id).name" : @"name",
             @"(id).min_level" : @"min_level",
             @"(id).max_level" : @"max_level",
             @"(id).default_floor" : @"default_floor",
             @"(id).map_rect" : @"map_rect",
             @"(id).continent_rect" : @"continent_rect",
             @"(id).tasks" : @"tasks",
             @"(id).skill_challenges" : @"skill_challenges",
             @"(id).sectors" : @"sectors"
             };
}
@end

@implementation GW2MapFloorRegion
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"id"];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    [mapping addPropertyMappingsFromArray:@[
                                            [RKRelationshipMapping relationshipMappingFromKeyPath:@"(id).maps"
                                                                                        toKeyPath:@"maps"
                                                                                      withMapping:[GW2MapFloorDetail mappingObject]]
                                            ]];
    mapping.forceCollectionMapping = YES;
    return mapping;
}

+ (NSDictionary *)mappingAttributes {
    
    return @{
             @"(id).name" : @"name",
             @"(id).label_coord" : @"label_coord",
             };
}
@end

#pragma mark - Map Floor Response
@implementation GW2MapFloorResponse
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping setSetNilForMissingRelationships:YES];
    [mapping addAttributeMappingsFromArray:@[@"texture_dims", @"clamped_view"]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"regions" mapping:[GW2MapFloorRegion mappingObject]];
    
    return mapping;
}
@end
