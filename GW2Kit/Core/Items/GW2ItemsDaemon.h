//
//  GW2ItemsDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import <Foundation/Foundation.h>
#import "GW2DefaultDaemon.h"

#define Items [GW2ItemsDaemon daemon]

@class GW2ItemDetail;
@class GW2RecipeDetail;

@interface GW2ItemsDaemon : GW2DefaultDaemon

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
             parameters:(NSDictionary *)parameters
             completion:(void (^)(NSError *error, GW2ItemDetail *itemDetail))completion;

/**
 Fetches the IDs of all known recipes in the game.
 
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of recipe IDs on success.
 */
- (void)recipesWithCompletion:(void (^)(NSError *error, NSArray *recipes))completion;

/**
 @brief Fetches the recipe detail for a given recipe ID.
 
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
@end
