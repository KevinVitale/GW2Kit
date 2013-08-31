//
//  GW2EventDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import <Foundation/Foundation.h>
#import "GW2DefaultDaemon.h"

#define Events [GW2EventDaemon daemon]

#pragma mark - GW2EventDaemon
/*!
 Dynamic events:
    - events: "/v1/events.json"
        Returns the current status of events for a specific world.
 
    - event_names: "/v1/event_names.json"
        Returns a list of localized event names.
 
    - map_names: "/v1/map_names.json"
        Returns a list of localized map names.
 
    - world_names: "/v1/world_names.json"
        Returns a list of localized world names.
 
    - event_details: "/v1/event_details.json"
        Returns detailed information about events.
 */
@interface GW2EventDaemon : GW2DefaultDaemon

#pragma mark - Requests
- (void)worldNamesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion;
- (void)mapNamesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion;
- (void)eventNamesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion;

/**
 Fetches event states based on the parameters provided. If no parameters are provided, it returns the state for every known event in the game.
 
 @param parameters A dictionary of parameters that can narrow the search.
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of states on success.
 
 @detail As an example, to fetch all active events in the Wayfarer Foothills (#28) on Maguuma (#1005) (and in English localization) looks like this:
 
    [Events statusWithParameters:@{
                    @"world_id" : @"1005",
                    @"map_id"   : @"28",
                    @"lang"     : @"en",
                    }
                        completion:^(NSError *error, NSArray *states) {
                            for(GW2EventStatus *status in states) {
                                if([status.state isEqualToString:@"Active"]) {
                                    printf("%s\n", status.description.UTF8String);
                                }
                            }
                        }];
 
 An example output of this is:
    mapID      : 28
    state      : Active
    eventID    : 67C17850-AC4C-4258-A03F-373021ECD10B
    worldID    : 1005
 */
- (void)statusWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *error, id result))completion;

/**
 Returns detailed information about events. This includes their static starting location in the world. This location is not updated dynamically, so it’s only accurate for events that don’t move.
 
 Optional parameters: event_id, lang
 */
- (void)detailsWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *error, id result))completion;
@end
