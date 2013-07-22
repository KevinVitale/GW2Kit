//
//  GW2DefaultDaemon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import "GW2DefaultDaemon.h"

#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
#else
    #import <Cocoa/Cocoa.h>
#endif


@interface GW2DefaultDaemon ()
+ (AFHTTPClient *)defaultHTTPClient;
@end

#pragma makr - GW2DefaultDaemon
@implementation GW2DefaultDaemon

#pragma mark - Registerting for notifications
- (void)registerForAppNotifications {
#if TARGET_OS_IPHONE
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:[UIApplication sharedApplication]];
#else
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidFinishLaunching:)
                                                 name:NSApplicationDidFinishLaunchingNotification
                                               object:NSApp];
#endif
}

+ (AFHTTPClient *)defaultHTTPClient {
    return [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"https://api.guildwars2.com"]];
}

#pragma mark - Initialization
- (id)init {
    self = [super initWithHTTPClient:[[self class] defaultHTTPClient]];
    if(self) {
        [self registerForAppNotifications];
        
#if !DEBUG
        RKLogConfigureByName("RestKit/Network", RKLogLevelOff);
        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelOff);
#else
        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelError);
#endif
        
        DLog(@"%@ initialized...", [self class]);
    }
    return self;
}

#pragma mark - Fetch Requests
- (void)namesForResource:(NSString *)resource
              parameters:(NSDictionary *)parameters
              completion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *names) {
        if(completion)
            completion(error, names);
    };
    
    [self getObjectsAtPath:[NSString stringWithFormat:@"/v1/%@_names.json", resource]
                parameters:parameters
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
}

- (void)fetchRequestAtPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    void (^finalCompletion)(NSError *, id) = ^(NSError *error, id result) {
        if(completion)
            completion(error, result);
    };
    
    // Fetch the event names
    [self getObjectsAtPath:path
                parameters:parameters
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       DLog(@"%@", error);
                       finalCompletion(error, nil);
                   }];
}

#pragma mark - Notifications
- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    DLog(@"App launched...");
}

#pragma mark - Daemon
+ (instancetype)daemon {
    return nil;
}
@end
