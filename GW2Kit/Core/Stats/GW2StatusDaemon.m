//
//  GW2StatusDaemon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import "GW2StatusDaemon.h"
#import "GW2StatusWvWMatches.h"

#pragma mark -
#pragma mark Status Daemon
@implementation GW2StatusDaemon

- (id)init {
    self = [super init];
    if(self) {
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2StatusDetail mapping]
                                                                                 method:RKRequestMethodGET
                                                                            pathPattern:@"/api/status.json"
                                                                                keyPath:@"api"
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2StatusCode mapping]
                                                                                 method:RKRequestMethodGET
                                                                            pathPattern:@"/api/status_codes.json"
                                                                                keyPath:@"status_codes"
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        
        /*
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2StatusWvWObjectives mapping]
                                                                                 method:RKRequestMethodGET
                                                                            pathPattern:@"/api/objectives.json"
                                                                                keyPath:@""
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
         */
        
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2StatusWvWMatches mapping]
                                                                                 method:RKRequestMethodGET
                                                                            pathPattern:@"/api/matches.json"
                                                                                keyPath:nil
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2StatusWvWRankings mapping]
                                                                                 method:RKRequestMethodGET
                                                                            pathPattern:@"/api/ratings.json"
                                                                                keyPath:nil
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        
    }
    return self;
}

#pragma mark - API
- (void)statusesWithCompletion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/api/status.json"
                  parameters:@{@"index" : @"cnt"}
                  completion:completion];
}
- (void)codesWithCompletion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/api/status_codes.json"
                  parameters:nil
                  completion:completion];
}

#pragma mark - App Notifications
- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self statusesWithCompletion:^(NSError *error, id result) {
        DLog(@"API statuses fetched...");
        DLog(@"API statuses:");
        for(id object in result) {
            printf("%s\n", [object description].UTF8String);
        }
    }];
    
    [self codesWithCompletion:^(NSError *error, id result) {
        DLog(@"API status codes fetched...");
        DLog(@"API status codes:");
        for(id object in result) {
            printf("%s\n", [object description].UTF8String);
        }
    }];
}

#pragma mark - Daemon
+ (AFHTTPClient *)defaultHTTPClient {
    return [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://gw2stats.net"]];
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
