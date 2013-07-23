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
    void (^finalCompletion)(NSError *, id) = ^(NSError *error, id result) {
        if(completion)
            completion(error, result);
    };
    
    [self namesForResource:@"wvw/objective"
                parameters:parameters
                completion:finalCompletion];
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
