//
//  GW2MapsDaemon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import "GW2MapsDaemon.h"
#import "GW2ContinentDetail.h"
#import "GW2MapResource.h"
#import "GW2MapFloorResponse.h"

@interface GW2MapsDaemon ()
@property (copy, readwrite, nonatomic) NSArray *southWest;
@property (copy, readwrite, nonatomic) NSArray *northEast;
@end


@implementation GW2MapsDaemon

#pragma mark - Initialization
- (id)init {
    self = [super init];
    if(self) {
        self.southWest = @[@0, @32768];
        self.northEast = @[@32768, @0];
        
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2ContinentDetail mappingObject]
                                                                            pathPattern:@"/v1/continents.json"
                                                                                keyPath:@"continents"
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2MapResource mappingObject]
                                                                            pathPattern:@"/v1/maps.json"
                                                                                keyPath:@"maps"
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2MapFloorResponse mappingObject]
                                                                            pathPattern:@"/v1/map_floor.json"
                                                                                keyPath:nil
                                                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];
    }
    return self;
}

#pragma mark - Fetches
- (void)continentsWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/v1/continents.json"
                  parameters:parameters
                  completion:completion];
}
- (void)mapsWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/v1/maps.json"
                  parameters:parameters
                  completion:completion];
}
- (void)floorWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/v1/map_floor.json"
                  parameters:parameters
                  completion:completion];
}

#pragma mark - App Notifications
- (void)applicationDidFinishLaunching:(NSNotification *)notification {

    [self continentsWithParameters:nil completion:^(NSError *error, id result) {
        DLog(@"Continents fetched...");
        for(id object in result) {
            printf("%s\n", [object description].UTF8String);
        }
    }];
    
    [self mapsWithParameters:@{@"map_id" : @80}
                  completion:^(NSError *error, id result) {
                      DLog(@"Maps fetched...");
                      for(id object in result) {
                          printf("%s\n", [object description].UTF8String);
                      }
                  }];
    
    [self floorWithParameters:@{@"continent_id" : @2, @"floor" : @1}
                   completion:^(NSError *error, id result) {
                       DLog(@"Map floor fetched...");
                       for(id object in result) {
                           printf("%s\n", [object description].UTF8String);
                       }
                   }];
}

#pragma mark - Daemon
+ (instancetype)daemon {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}
@end
