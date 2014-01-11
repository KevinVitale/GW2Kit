//
//  GW2MapRegion.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2MapRegion.h"
#import "MTLValueTransformer+CoreGraphics.h"
#import "GW2Object+Private.h"

@interface GW2MapRegion : _GW2Object <GW2MapRegion>
@property       (nonatomic, readonly)   CGPoint labelCoordinate;
@property (copy, nonatomic, readonly)   NSArray *subregions;
@end

@interface GW2MapSubRegion : _GW2Object
@property       (nonatomic, readonly) NSInteger minimumLevel;
@property       (nonatomic, readonly) NSInteger maximumLevel;
@property       (nonatomic, readonly) NSInteger floor;
@property       (nonatomic, readonly) CGRect    mapRegionRect;
@property       (nonatomic, readonly) CGRect    continentRect;
@property (copy, nonatomic, readonly) NSArray   *pointsOfInterest;
@property (copy, nonatomic, readonly) NSArray   *tasks;
@property (copy, nonatomic, readonly) NSArray   *skillChallenges;
@property (copy, nonatomic, readonly) NSArray   *sectors;
@end


@interface GW2MapObject : _GW2Object
@property        (nonatomic, readonly) CGPoint coordinate;
@end
@implementation GW2MapObject
+ (NSValueTransformer *)coordinateJSONTransformer {
    return MTLReversiblePointTransformer(1);
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"coordinate"  : @"coord",
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
//------------------------------------------------------------------------------
@interface _GW2MapSubRegionPOI : GW2MapObject <GW2MapSubRegionPointOfInterest>
@property       (nonatomic, readwrite) NSInteger floor;
@property (copy, nonatomic, readwrite) NSString *type;
@end
@implementation _GW2MapSubRegionPOI
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID"  : @"poi_id",
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
//------------------------------------------------------------------------------
@interface _GW2MapSubRegionTask : GW2MapObject <GW2MapSubRegionTask>
@property       (nonatomic, readwrite) NSInteger level;
@end
@implementation _GW2MapSubRegionTask
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID" : @"task_id",
        @"name"     : @"objective"
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
//------------------------------------------------------------------------------
@interface _GW2MapSubregionSkillChallenge : GW2MapObject <GW2MapSubRegionSkillChallenge>
@end
@implementation _GW2MapSubregionSkillChallenge
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID" : NSNull.null,
        @"name"     : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
//------------------------------------------------------------------------------
@interface _GW2MapSubRegionSector : GW2MapObject <GW2MapSubRegionSector>
@property       (nonatomic, readonly) NSInteger level;
@end
@implementation _GW2MapSubRegionSector
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID" : @"sector_id",
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
//------------------------------------------------------------------------------

@implementation GW2MapRegion
+ (NSValueTransformer *)labelCoordinateJSONTransformer {
    return MTLReversiblePointTransformer(0);
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"labelCoordinate"  : @"label_coord",
        @"subregions"       : @"maps",
        @"objectID"         : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
+ (NSValueTransformer *)subregionsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSDictionary *subregions) {
        NSMutableArray *mutableSubregionsArray = [NSMutableArray arrayWithCapacity:subregions.count];
        for(NSString *subregionID in subregions) {
            GW2MapSubRegion *subregion = [GW2MapSubRegion objectWithID:@(subregionID.integerValue)
                                                                  name:nil
                                                    fromJSONDictionary:subregions[subregionID]
                                                                 error:nil];
            [mutableSubregionsArray addObject:subregion];
        }
        return [mutableSubregionsArray copy];
    }
                                                         reverseBlock:^id (NSArray *subregionsArray) {
                                                             NSMutableDictionary *subregions = [NSMutableDictionary new];
                                                             for(GW2MapSubRegion *subregion in subregionsArray) {
                                                                 subregions[[subregion.objectID stringValue]] = [MTLJSONAdapter JSONDictionaryFromModel:subregion];
                                                             }
                                                             return [subregions copy];
                                                         }];
}
@end


@implementation GW2MapSubRegion
+ (NSValueTransformer *)continentRectJSONTransformer {
    return MTLReversibleRectTransformer(0);
}
+ (NSValueTransformer *)mapRegionRectJSONTransformer {
    return MTLReversibleRectTransformer(0);
}
+ (NSValueTransformer *)pointsOfInterestJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *POIArray) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:POIArray.count];
        for(NSDictionary *pointOfInterest in POIArray) {
            _GW2MapSubRegionPOI *poi = [_GW2MapSubRegionPOI objectWithID:nil
                                                                    name:nil
                                                      fromJSONDictionary:pointOfInterest
                                                                   error:nil];
            [mutableArray addObject:poi];
        }
        return [mutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *pointsOfInterest) {
                                                             NSMutableArray *mutableArray = [NSMutableArray new];
                                                             for(_GW2MapSubRegionPOI *poi in pointsOfInterest) {
                                                                 [mutableArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:poi]];
                                                             }
                                                             return [mutableArray copy];
                                                         }];
}
+ (NSValueTransformer *)tasksJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *tasksArray) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:tasksArray.count];
        for(NSDictionary *task in tasksArray) {
            _GW2MapSubRegionTask *aTask = [_GW2MapSubRegionTask objectWithID:nil
                                                                        name:nil
                                                          fromJSONDictionary:task
                                                                       error:nil];
            [mutableArray addObject:aTask];
        }
        return [mutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *tasks) {
                                                             NSMutableArray *mutableArray = [NSMutableArray new];
                                                             for(_GW2MapSubRegionTask *poi in tasks) {
                                                                 [mutableArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:poi]];
                                                             }
                                                             return [mutableArray copy];
                                                         }];
}
+ (NSValueTransformer *)skillChallengesJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *skillChallengesArray) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:skillChallengesArray.count];
        for(NSDictionary *skillChallenge in skillChallengesArray) {
            _GW2MapSubregionSkillChallenge *aSkillChallenge
            = [_GW2MapSubregionSkillChallenge objectWithID:nil
                                                      name:nil
                                        fromJSONDictionary:skillChallenge
                                                     error:nil];
            [mutableArray addObject:aSkillChallenge];
        }
        return [mutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *skillChallenges) {
                                                             NSMutableArray *mutableArray = [NSMutableArray new];
                                                             for(_GW2MapSubregionSkillChallenge *skillChallenge in skillChallenges) {
                                                                 [mutableArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:skillChallenge]];
                                                             }
                                                             return [mutableArray copy];
                                                         }];
}
+ (NSValueTransformer *)sectorsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *sectorsArray) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:sectorsArray.count];
        for(NSDictionary *sector in sectorsArray) {
            _GW2MapSubRegionSector *aSector
            = [_GW2MapSubRegionSector objectWithID:nil
                                              name:nil
                                fromJSONDictionary:sector
                                             error:nil];
            [mutableArray addObject:aSector];
        }
        return [mutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *sectors) {
                                                             NSMutableArray *mutableArray = [NSMutableArray new];
                                                             for(_GW2MapSubRegionSector *sector in sectors) {
                                                                 [mutableArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:sector]];
                                                             }
                                                             return [mutableArray copy];
                                                         }];
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"mapRegionRect"    : @"map_rect",
        @"continentRect"    : @"continent_rect",
        @"minimumLevel"     : @"min_level",
        @"maximumLevel"     : @"max_level",
        @"floor"            : @"default_floor",
        @"pointsOfInterest" : @"points_of_interest",
        @"skillChallenges"  : @"skill_challenges",
        @"objectID"         : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end