//
//  GW2MapFloorResponse.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import <Foundation/Foundation.h>




@class RKObjectMapping;
@interface GW2BaseMapResource : NSObject
+ (RKObjectMapping *)mappingObject;
@end


@interface GW2MapFloorPointOfInterest : GW2BaseMapResource
@property (copy, nonatomic) NSString *poi_id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *floor;
@property (copy, nonatomic) NSArray *coord;
@property (copy, nonatomic) NSString *type;
@end


@interface GW2MapFloorDetail : GW2BaseMapResource
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *min_level;
@property (copy, nonatomic) NSNumber *max_level;
@property (copy, nonatomic) NSNumber *default_floor;
@property (copy, nonatomic) NSArray *map_rect;
@property (copy, nonatomic) NSArray *continent_rect;
@property (copy, nonatomic) NSArray *points_of_interest; // relationship -> 'GW2MapFloorPointOfInterest'
@property (copy, nonatomic) NSArray *tasks;
@property (copy, nonatomic) NSArray *skill_challenges;
@property (copy, nonatomic) NSArray *sectors;
@end

@interface GW2MapFloorRegion : GW2BaseMapResource
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSArray *label_coord;
@property (copy, nonatomic) NSArray *maps; // relationship -> 'GW2MapFloorDetail'
@end

#pragma mark - Map Floor Response
@interface GW2MapFloorResponse : GW2BaseMapResource
@property (copy, nonatomic) NSArray *texture_dims;
@property (copy, nonatomic) NSArray *clamped_view;
@property (copy, nonatomic) NSArray *regions; // relationship -> 'GW2MapFloorRegion'
@end
