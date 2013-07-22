//
//  GW2MapsDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import <GW2Kit/GW2Kit.h>

@interface GW2MapsDaemon : GW2DefaultDaemon

@property (copy, readonly, nonatomic) NSArray *southWest;
@property (copy, readonly, nonatomic) NSArray *northEast;

/**
 Returns a list of continents, and information about each continent. This information is meant to be used in conjunction with the world map tile service, and with the map floor API.
 
 Optional parameter: lang
 */
- (void)continentsWithParameters:(NSDictionary *)parameters
                      completion:(void (^)(NSError *error, id result))completion;

/**
 Returns summary about one or all maps in the game. The summary contains information like the floors that a map is on, and translation data that can be used to translate world coordinates to map coordinates.
 
 Optional parameters: lang, map_id
 */
- (void)mapsWithParameters:(NSDictionary *)parameters
                completion:(void (^)(NSError *error, id result))completion;

/**
 Returns detailed information about a map floor. This data can be used to populate a world map. Any coordinates provided have already been translated to map coordinates, which can be used in conjunction with the world map tile service.
 The data provided currently only contains static content. Dynamic content, such as vendors, is not currently available.
 
 Required parameters: continent_id, floor
 Optional parameter: lang
 */
- (void)floorWithParameters:(NSDictionary *)parameters
                 completion:(void (^)(NSError *error, id result))completion;
@end
