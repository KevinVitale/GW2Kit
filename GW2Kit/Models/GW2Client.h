//
//  GW2Client.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

#define GW2 [GW2Client sharedClient]

@class GW2ItemDetail;
@class GW2RecipeDetail;
@class GW2WvWMatchDetail;
@class GW2GuildDetail;
@class GW2Build;
@class RACSignal;

#pragma mark -
#pragma mark GW2 Client
@interface GW2Client : RKObjectManager

#pragma mark - Resource Names
/**
 Fetches the names of a given resource, such as `/v1/event_names.json`.
 
 @param resource The name of desired resource. Valid values are `event`, `world`, `map`, and `wvw/objective`.
 @param parameters Optional parameters, most likely language, sent in the request.
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of names for the resource on success.
 
 @detail As an example, you can request the names for all the maps in German like this:

    [GW2 namesForResource:@"map"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   for(GW2ResourceName *name in names) {
                       printf("%s\n", name.description.UTF8String);
                   }
               }];
 
 An example output of one map resource is:
    name   : Frostgorge Sound
    id     : 30
 
 */
- (void)namesForResource:(NSString *)resource
              parameters:(NSDictionary *)parameters
              completion:(void (^)(NSError *error, NSArray *names))completion;


/**
 Fetches the IDs of all known items in the game.
 
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of item IDs on success.
 */
- (void)itemsWithCompletion:(void (^)(NSError *error, NSArray *items))completion;

/**
 Fetches the item detail for a given item ID.
 
 @param itemID The ID of the item being detailed.
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the item detail on success.
 */
- (void)itemDetailForID:(NSString *)itemID
             completion:(void (^)(NSError *error, GW2ItemDetail *itemDetail))completion;

/**
 Fetches event states based on the parameters provided. If no parameters are provided, it returns the state for every known event in the game.
 
 @param parameters A dictionary of parameters that can narrow the search.
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of states on success.
 
 @detail As an example, to fetch all active events in the Wayfarer Foothills (#28) on Maguuma (#1005) (and in English localization) looks like this:
 
    [GW2 eventStatesWithParameters:@{
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
- (void)eventStatesWithParameters:(NSDictionary *)parameters
                       completion:(void (^)(NSError *error, NSArray *states))completion;

/**
 Fetches the current list of WvW matches.
 
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of matches on success.
 */
- (void)wvwMatchesWithCompletion:(void (^)(NSError *error, NSArray *matches))completion;

/**
 Fetches match details for a given match ID.
 
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the match detail on success.
 */
- (void)wvwMatchDetailForID:(NSString *)matchID
                 completion:(void (^)(NSError *error, GW2WvWMatchDetail *matchDetail))completion;

/**
 Fetches the IDs of all known recipes in the game.
 
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of recipe IDs on success.
 */
- (void)recipesWithCompletion:(void (^)(NSError *error, NSArray *recipes))completion;

/**
 Fetches the recipe detail for a given recipe ID.
 
 @param recipeID The ID of the recipe being detailed.
 @param parameters Optional parameters, most likely language, sent in the request.
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the item detail on success.
 
 @detail As an example, let's fetch the recipe detil for `id` equal to `1`:
    [GW2 recipeDetailForID:@"1"
                parameters:nil
                completion:^(NSError *error, GW2RecipeDetail *recipeDetail) {
                    printf("%s", recipeDetail.description.UTF8String);
                }];
 
 An example out of this is:
    recipeID                                : 1
    outputItemCount                         : 1
    timeToCraft                             : 2000
    outputItemID                            : 19713
    minimumRating                           : 75
    type                                    : Refinement
    ingredients                             : (
        {
        count = 4;
        "item_id" = 19726;
    }
    )
 */
- (void)recipeDetailForID:(NSString *)recipeID
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *error, GW2RecipeDetail *recipeDetail))completion;

/**
 Returns the current build ID. This can be useful for a number of purposes, such as resetting event timers due to server restarts.
 */
- (void)buildWithCompletion:(void (^)(NSError *error, GW2Build *build))completion;

/**
 Returns all of the colors / dyes in the game, and their color-shifting properties.
 */
- (void)colorsWithCompletion:(void (^)(NSError *error, NSArray *colors))completion;

/**
 Returns guild details for a specified guild_id or guild_name.
 */
- (void)guildDetailWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *error, GW2GuildDetail *guildDetail))completion;

/**
 Singleton object.
 */
+ (GW2Client *)sharedClient;
@end

@interface GW2Client (Reactive)
- (RACSignal *)signalOfNamesForResource:(NSString *)resource
                             parameters:(NSDictionary *)parameters;
@end