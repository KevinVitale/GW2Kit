//
//  GW2MapResource.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2MapResource : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *map_name;
@property (copy, nonatomic) NSNumber *min_level;
@property (copy, nonatomic) NSNumber *max_level;
@property (copy, nonatomic) NSNumber *default_floor;
@property (copy, nonatomic) NSArray *floors;
@property (copy, nonatomic) NSNumber *region_id;
@property (copy, nonatomic) NSString *region_name;
@property (copy, nonatomic) NSNumber *continent_id;
@property (copy, nonatomic) NSString *continent_name;
@property (copy, nonatomic) NSArray *map_rect;
@property (copy, nonatomic) NSArray *continent_rect;


+ (RKObjectMapping *)mappingObject;

@end
