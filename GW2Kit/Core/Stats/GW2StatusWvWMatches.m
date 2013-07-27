//
//  GW2StatusWvWMatches.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import "GW2StatusWvWMatches.h"
#import <RestKit/RestKit.h>
#import <objc/runtime.h>

@implementation GW2StatusWvWWorld
- (NSString *)description {
    
    NSMutableString *description = [NSMutableString stringWithString:@""];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [description appendFormat:@"%@: %@\n", [propertyName capitalizedString], [self valueForKey:propertyName]];
    }
    return description;
}
+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"color": @"color",
                                                  @"name": @"name",
                                                  @"objectives": @"objectives",
                                                  @"rating": @"rating",
                                                  @"ppt": @"pointsPerTick",
                                                  @"score" : @"score",
                                                  @"world_id" : @"id"
                                                  }];
    return mapping;
}
@end


@implementation GW2StatusWvWMatch
- (NSString *)description {
    
    NSMutableString *description = [NSMutableString stringWithString:@""];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [description appendFormat:@"%@: %@\n", [propertyName capitalizedString], [self valueForKey:propertyName]];
    }
    return description;
}
+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"match_id": @"matchID",
                                                  @"start_date": @"startDate",
                                                  @"end_date": @"endDate",
                                                  @"last_update": @"lastUpdated",
                                                  @"unique_id": @"uniqueID",
                                                  }];
    [mapping addRelationshipMappingWithSourceKeyPath:@"worlds" mapping:[GW2StatusWvWWorld mapping]];
    return mapping;
}
@end


@implementation GW2StatusWvwRegionMatches
@dynamic name;

- (NSString *)name {
    return ([self.prefix isEqualToString:@"eu"] ? @"Europe" : @"North America");
}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    mapping.forceCollectionMapping = YES;
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"prefix"];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"(prefix)"
                                                                            toKeyPath:@"matches"
                                                                          withMapping:[GW2StatusWvWMatch mapping]]];
    return mapping;
}

@end
@implementation GW2StatusWvWMatches
+ (RKObjectMapping *)mapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"retrieve_time": @"retrievalDate",
                                                  }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"region"
                                                                            toKeyPath:@"regions"
                                                                          withMapping:[GW2StatusWvwRegionMatches mapping]]];
    
    return mapping;
}
@end
