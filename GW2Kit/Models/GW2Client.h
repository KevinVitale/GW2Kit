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

@interface GW2Client : AFHTTPClient

- (void)itemsWithCompletion:(void (^)(NSError *error, NSArray *items))completion;

- (void)itemDetailForID:(NSString *)itemID
             completion:(void (^)(NSError *error, GW2ItemDetail *itemDetail))completion;

- (void)mapsWithParameters:(NSDictionary *)parameters
                completion:(void (^)(NSError *error, NSArray *maps))completion;

- (void)worldsWithParameters:(NSDictionary *)parameters
                  completion:(void (^)(NSError *error, NSArray *worlds))completion;

- (void)eventsWithParameters:(NSDictionary *)parameters
                  completion:(void (^)(NSError *error, NSArray *events))completion;

- (void)eventStatesWithParameters:(NSDictionary *)parameters
                       completion:(void (^)(NSError *error, NSArray *states))completion;

- (void)wvwMatchesWithCompletion:(void (^)(NSError *error, NSArray *matches))completion;
- (void)wvwMatchDetailForID:(NSString *)matchID completion:(void (^)(NSError *error, GW2WvWMatchDetail *matchDetail))completion;
- (void)wvwObjectivesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, NSArray *))completion;

- (void)recipesWithCompletion:(void (^)(NSError *error, NSArray *recipes))completion;

- (void)recipeDetailForID:(NSString *)recipeID
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *error, GW2RecipeDetail *recipeDetail))completion;

+ (GW2Client *)sharedClient;
@end
