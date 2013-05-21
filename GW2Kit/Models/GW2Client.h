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

+ (GW2Client *)sharedClient;
@end
