//
//  GW2WvWDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import <Foundation/Foundation.h>
#import "GW2DefaultDaemon.h"

@class GW2WvWMatchDetail;

@interface GW2WvWDaemon : GW2DefaultDaemon
/**
 Fetches the current list of WvW matches.
 
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of matches on success.
 */
- (void)matchesWithCompletion:(void (^)(NSError *error, NSArray *matches))completion;

/**
 Fetches match details for a given match ID.
 
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the match detail on success.
 */
- (void)matchDetailForID:(NSString *)matchID
              completion:(void (^)(NSError *error, GW2WvWMatchDetail *matchDetail))completion;

- (void)objectiveNamesWithParameters:(NSDictionary *)parameters
                          completion:(void (^)(NSError *error, id result))completion;
@end