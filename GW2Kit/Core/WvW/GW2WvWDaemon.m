    //
//  GW2WvWDaemon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import "GW2WvWDaemon.h"
#import "GW2WvWMatch.h"
#import "GW2WvWMatchDetail.h"
#import "GW2ResourceName.h"
#import "GW2StatusDaemon.h"
#import <RestKit/RestKit.h>

@implementation GW2WvWDaemon
- (id)init {
    self = [super init];
    if(self) {
        [self addResponseDescriptorsFromArray:@[// WvW Matche Details: wvw/matches.json
                                                [RKResponseDescriptor responseDescriptorWithMapping:[GW2WvWMatch mappingObject]
                                                                                             method:RKRequestMethodGET
                                                                                        pathPattern:@"/v1/wvw/matches.json"
                                                                                            keyPath:@"wvw_matches"
                                                                                        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                                
                                                // WvW Matche Details: wvw/match_details.json
                                                [RKResponseDescriptor responseDescriptorWithMapping:[GW2WvWMatchDetail mappingObject]
                                                                                             method:RKRequestMethodGET
                                                                                        pathPattern:@"/v1/wvw/match_details.json"
                                                                                            keyPath:nil
                                                                                        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                                
                                                // WvW Matche Details: wvw/objective_names.json
                                                [RKResponseDescriptor responseDescriptorWithMapping:[GW2ResourceName mappingObject]
                                                                                             method:RKRequestMethodGET
                                                                                        pathPattern:@"/v1/wvw/objective_names.json"
                                                                                            keyPath:nil
                                                                                        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]]];
    }
    return self;
}

- (void)objectiveNamesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    
    [self namesForResource:@"wvw/objective"
                parameters:parameters
                completion:completion];
}

- (void)matchesWithCompletion:(void (^)(NSError *, NSArray *))completion {
    
    [self fetchRequestAtPath:@"/v1/wvw/matches.json"
                  parameters:nil
                  completion:completion];
}

- (void)matchDetailForID:(NSString *)matchID
              completion:(void (^)(NSError *, GW2WvWMatchDetail *))completion {
    
    [self fetchRequestAtPath:@"/v1/wvw/match_details.json"
                  parameters:@{ @"match_id" : matchID }
                  completion:^(NSError *error, id result) {
                      if(completion) {
                          completion(error, [result lastObject]);
                      }
                  }];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {

    /*
    static BOOL pullDetails = YES;
    [self matchesWithCompletion:^(NSError *error, NSArray *matches) {
        DLog(@"WvW Matches fetched...");
        for(id object in matches) {
            printf("%s\n", [object description].UTF8String);
            if(pullDetails) {
                pullDetails = NO;
                [self matchDetailForID:[object matchID]
                            completion:^(NSError *error, GW2WvWMatchDetail *matchDetail) {
                                printf("%s\n", matchDetail.description.UTF8String);
                            }];
            }
        }
    }];
    
    [self objectiveNamesWithParameters:nil
                            completion:^(NSError *error, id result) {
                                DLog(@"Map names fetched...");
                                DLog(@"Map status:\n");
                                for (id object in result) {
                                    printf("%s\n", [object description].UTF8String);
                                }
                            }];
     */

    [self matchStatusesWithParameters:nil
                           completion:^(NSError *error, id results) {
                               DLog(@"Match statuses fetched...");
                               DLog(@"Map statuses:");
                               for(id region in [results valueForKey:@"regions"]) {
                                   printf("WvW Region: %s\n", [region name].UTF8String);
                                   printf("---------------------------\n");
                                   for(id match in [region matches]) {
                                       printf("---------------------------\n");
                                       printf("WvW Match: %s\n", [match matchID].UTF8String);
                                       for(id world in [match worlds]) {
                                           printf("---------------------------\n");
                                           printf("%s\n", [world description].UTF8String);
                                       }
                                   }
                               }
                           }];
    
    [self rankWithCompletion:^(NSError *error, id results) {
        DLog(@"Rank statuses fetched...");
        DLog(@"\n\nNorth American Ranks:");
        printf("---------------------------\n");
        for(id rank in [results valueForKey:@"northAmericanRankings"]) {
            printf("%s: #%s (%.0f pts.)\n",
                   [rank name].UTF8String,
                   [[rank valueForKeyPath:@"rating.current_rank"] description].UTF8String,
                   [[rank valueForKeyPath:@"rating.current_rating"] floatValue]);
        }
        
        DLog(@"\n\nEuropean Ranks:");
        printf("---------------------------\n");
        for(id rank in [results valueForKey:@"europeanRankings"]) {
            printf("%s: #%s (%.0f pts.)\n",
                   [rank name].UTF8String,
                   [[rank valueForKeyPath:@"rating.current_rank"] description].UTF8String,
                   [[rank valueForKeyPath:@"rating.current_rating"] floatValue]);
        }
    }];
}

+ (instancetype)daemon {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}
@end


@implementation GW2WvWDaemon (GW2StatsDotNet)
- (void)matchStatusesWithParameters:(NSDictionary *)parameters
                         completion:(void (^)(NSError *, id))completion {
    if(parameters) {
        parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [parameters setValue:@"true" forKey:@"objectives"];
    }
    else {
        parameters = @{@"objectives" : @"true"};
    }
    [Stats fetchRequestAtPath:@"/api/matches.json"
                   parameters:parameters
                   completion:^(NSError *error, id result) {
                       if(completion) {
                           completion(error, [result lastObject]);
                       }
                   }];
}

- (void)objectiveStatusesWithParameters:(NSDictionary *)parameters
                             completion:(void (^)(NSError *, id))completion {
    [Stats fetchRequestAtPath:@"/api/objectives.json"
                   parameters:parameters
                   completion:completion];
}

- (void)rankWithCompletion:(void (^)(NSError *, id))completion {
    [Stats fetchRequestAtPath:@"/api/ratings.json"
                   parameters:nil
                   completion:^(NSError *error, id result) {
                       if(completion) {
                           completion(error, [result lastObject]);
                       }
                   }];
}
@end