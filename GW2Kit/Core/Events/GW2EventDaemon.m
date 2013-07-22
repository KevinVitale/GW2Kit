//
//  GW2EventDaemon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import "GW2EventDaemon.h"
#import "GW2ResourceName.h"
#import "GW2EventStatus.h"
#import "GW2EventDetail.h"


#pragma mark - Private
@interface GW2EventDaemon ()
@property (copy) NSArray *eventNames;
@property (copy) NSArray *mapNames;
@property (copy) NSArray *worldNames;
@end

#pragma mark - GW2EventDaemon
@implementation GW2EventDaemon

#pragma mark - Initialization
- (id)init {
    self = [super init];
    if(self) {
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2ResourceName mappingObject]
                                                                            pathPattern:@"/v1/world_names.json"
                                                                                keyPath:nil
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2ResourceName mappingObject]
                                                                            pathPattern:@"/v1/map_names.json"
                                                                                keyPath:nil
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2ResourceName mappingObject]
                                                                            pathPattern:@"/v1/event_names.json"
                                                                                keyPath:nil
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2EventStatus mappingObject]
                                                                            pathPattern:@"/v1/events.json"
                                                                                keyPath:@"events"
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2EventDetail mappingObject]
                                                                            pathPattern:@"/v1/event_details.json"
                                                                                keyPath:@"events"
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        
        
    }
    return self;
}

#pragma mark - Requests
- (void)statusWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/v1/events.json"
                  parameters:parameters
                  completion:completion];
}

- (void)detailsWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/v1/event_details.json"
                  parameters:parameters
                  completion:completion];
}

#pragma mark - Private Fetch Methods
- (void)worldNamesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    
    [self namesForResource:@"world"
                parameters:parameters
                completion:completion];
}
- (void)mapNamesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    
    [self namesForResource:@"map"
                parameters:parameters
                completion:completion];
}
- (void)eventNamesWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    
    [self namesForResource:@"event"
                parameters:parameters
                completion:completion];
}

#pragma mark - Application Notifications
- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    // Pull the world names if we don't have them.
    if(![self.worldNames count]) {
        [self worldNamesWithParameters:nil
                            completion:^(NSError *error, id result) {
                                self.worldNames = result;
                                DLog(@"World names fetched...");
                                DLog(@"World status:\n");
                                for (id object in self.worldNames) {
                                    printf("%s", [object description].UTF8String);
                                }
                            }];
    }
    
    // Pull the world names if we don't have them.
    if(![self.mapNames count]) {
        [self mapNamesWithParameters:nil
                          completion:^(NSError *error, id result) {
                              self.mapNames = result;
                              DLog(@"Map names fetched...");
                              DLog(@"Map status:\n");
                              for (id object in self.mapNames) {
                                  printf("%s", [object description].UTF8String);
                              }
                          }];
    }
    
    // Pull the event names if we don't have them.
    if(![self.eventNames count]) {
        [self eventNamesWithParameters:nil
                            completion:^(NSError *error, id result) {
                                self.eventNames = result;
                                DLog(@"Event names fetched...");
                                [self statusWithParameters:@{@"world_id" : @1010, @"map_id" : @50}
                                                 completion:^(NSError *error, id result) {
                                                     DLog(@"Event statuses fetched...");
                                                     DLog(@"Event status:\n");
                                                     for (id object in result) {
                                                         printf("%s", [object description].UTF8String);
                                                     }
                                                 }];
                            }];
    }
    
    [self detailsWithParameters:@{@"event_id" : @"BAD81BA0-60CF-4F3B-A341-57C426085D48"}
                     completion:^(NSError *error, id result) {
                         DLog(@"Event details fetched...");
                         DLog(@"Event details:\n");
                         for(id object in result) {
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
