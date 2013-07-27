//
//  GW2StatusWvWRankings.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import "GW2StatusWvWRankings.h"
#import <RestKit/RestKit.h>
#import <objc/runtime.h>

@implementation GW2StatusWvWRank
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
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"id"];
    mapping.forceCollectionMapping = YES;
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"(id).world_name": @"name",
                                                  @"(id).data": @"rating",
                                                  }];
    return mapping;
}
@end

@implementation GW2StatusWvWRankings
- (NSArray *)_sortArray:(NSArray *)arrayToSort {
    return [arrayToSort sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSInteger rank1 = [[obj1 valueForKeyPath:@"rating.current_rank"] integerValue];
        NSInteger rank2 = [[obj2 valueForKeyPath:@"rating.current_rank"] integerValue];
        if(rank1 < rank2) return NSOrderedAscending;
        else if (rank1 > rank2) return NSOrderedDescending;
        else return NSOrderedSame;
    }];
}
- (NSArray *)northAmericanRankings {
    return [self _sortArray:_northAmericanRankings];
}
- (NSArray *)europeanRankings {
    return [self _sortArray:_europeanRankings];
}

+ (RKObjectMapping *)mapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"retrieve_time" : @"retrievalDate",
                                                  @"results" : @"count",
                                                  }];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"na.ratings"
                                                                            toKeyPath:@"northAmericanRankings"
                                                                          withMapping:[GW2StatusWvWRank mapping]]];
    
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"eu.ratings"
                                                                            toKeyPath:@"europeanRankings"
                                                                          withMapping:[GW2StatusWvWRank mapping]]];
    
    return mapping;
}
@end
