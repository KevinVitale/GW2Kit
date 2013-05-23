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
@class RACSignal;
@class RACCommand;

@interface GW2Client : RKObjectManager
@property (strong, readonly, nonatomic) RACCommand *resourceNameCommand;

- (RACSignal *)namesForResource:(NSString *)resource
                     parameters:(NSDictionary *)parameters
                     completion:(void (^)(NSError *error, NSArray *names))completion;

- (void)itemsWithCompletion:(void (^)(NSError *error, NSArray *items))completion;

- (void)itemDetailForID:(NSString *)itemID
             completion:(void (^)(NSError *error, GW2ItemDetail *itemDetail))completion;

- (void)eventStatesWithParameters:(NSDictionary *)parameters
                       completion:(void (^)(NSError *error, NSArray *states))completion;

- (void)wvwMatchesWithCompletion:(void (^)(NSError *error, NSArray *matches))completion;

- (void)wvwMatchDetailForID:(NSString *)matchID
                 completion:(void (^)(NSError *error, GW2WvWMatchDetail *matchDetail))completion;

- (void)recipesWithCompletion:(void (^)(NSError *error, NSArray *recipes))completion;

- (void)recipeDetailForID:(NSString *)recipeID
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *error, GW2RecipeDetail *recipeDetail))completion;

+ (GW2Client *)sharedClient;
@end
