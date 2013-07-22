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
 Returns the current build ID. This can be useful for a number of purposes, such as resetting event timers due to server restarts.
 */
- (void)buildWithCompletion:(void (^)(NSError *error, GW2Build *build))completion;

/**
 Returns all of the colors / dyes in the game, and their color-shifting properties.
 */
- (void)colorsWithCompletion:(void (^)(NSError *error, NSArray *colors))completion;



/**
 Singleton object.
 */
+ (GW2Client *)sharedClient;
@end

@interface GW2Client (Reactive)
- (RACSignal *)signalOfNamesForResource:(NSString *)resource
                             parameters:(NSDictionary *)parameters;
@end