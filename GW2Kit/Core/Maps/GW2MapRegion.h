//
//  GW2MapRegion.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2Object.h"

/**
 *  GW2MapRegion
 *  Represents a region on the map, such as:
 *    - Ascalon
 *    - Shiverpeak Mountains
 *    - Ruins of Orr
 *    - Kryta
 *      etc.
 *
 *  Each map region has sub-regions, such as:
 *    - Hoelbrak
 *    - Wayfarer Foothills
 *    - Lion's Arch
 *    - Rata Sum
 *      etc.
 *  (note: each sub-region is a map returned by map_names.json)
 */
@interface GW2MapRegion : GW2Object
@property       (nonatomic, readonly)   CGPoint labelCoordinate;
@property (copy, nonatomic, readonly)   NSArray *subregions;
@end

@class GW2MapSubRegionSector;

/**
 *  GW2MapSubRegion
 *  Represents a sub-region within a map region.
 *
 *  An example of of a (small) sub-region is:
     "649": {
                "name": "Snaff Memorial Lab",
                "min_level": 0,
                "max_level": 0,
                "default_floor": 1,
                "map_rect": [
                    [
                        -30720,
                        -30720
                    ],
                    [
                        30720,
                        30720
                    ]
                ],
                "continent_rect": [
                    [
                        4608,
                        19648
                    ],
                    [
                        7168,
                        22208
                    ]
                ],
                "points_of_interest": [
                    {
                        "poi_id": 1182,
                        "name": "Zojja's Workstation (Don't Touch!)",
                        "type": "landmark",
                        "floor": 1,
                        "coord": [
                            5414.93,
                            20888
                        ]
                    }
                ],
                "tasks": [],
                "skill_challenges": [],
                "sectors": [
                    {
                        "sector_id": 920,
                        "name": "Snaff Memorial Lab",
                        "level": 0,
                        "coord": [
                            5246.62,
                            20962.8
                        ]
                    }
                ]
            },
 *
 */
@interface GW2MapSubRegion : GW2Object
@property       (nonatomic, readonly) NSInteger minimumLevel;
@property       (nonatomic, readonly) NSInteger maximumLevel;
@property       (nonatomic, readonly) NSInteger floor;
@property       (nonatomic, readonly) CGRect    mapRegionRect;
@property       (nonatomic, readonly) CGRect    continentRect;
@property (copy, nonatomic, readonly) NSArray   *pointsOfInterest;
@property (copy, nonatomic, readonly) NSArray   *tasks;
@property (copy, nonatomic, readonly) NSArray   *skillChallenges;
@property (nonatomic, readonly) GW2MapSubRegionSector *sector;
@end


@interface GW2MapSubRegionPointOfInterest : GW2Object
@property (copy, nonatomic, readonly) NSString  *type;
@property       (nonatomic, readonly) NSInteger floor;
@property       (nonatomic, readonly) CGPoint   coordinate;
@end

@interface GW2MapSubRegionTask : GW2Object
@property (nonatomic, readonly) NSInteger   level;
@property (nonatomic, readonly) CGPoint     coordinate;
@end

@interface GW2MapSubRegionSkillChallenge : GW2Object
@property (nonatomic, readonly) CGPoint     coordinate;
@end

@interface GW2MapSubRegionSector : GW2Object
@property (nonatomic, readonly) NSInteger   level;
@property (nonatomic, readonly) CGPoint     coordinate;
@end