//
//  GW2DefaultDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import <RestKit/RestKit.h>


#pragma mark - GW2DefaultDaemon
/**
 Provides a basic daemon. Meant to be subclassed.
 */
@interface GW2DefaultDaemon : RKObjectManager
- (void)registerForAppNotifications;
- (void)applicationDidFinishLaunching:(NSNotification *)notification;

/**
 Fetches the names of a given resource, such as `/v1/event_names.json`.
 
 @param resource The name of desired resource. Valid values are `event`, `world`, `map`, and `wvw/objective`.
 @param parameters Optional parameters, most likely language, sent in the request.
 @param completion The completion handler invoked once the request completes. It provides an error (if any) and the list of names for the resource on success.
 
 @detail As an example, you can request the names for all the maps in German like this:

    [GW2 namesForResource:@"map"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   for(GW2ResourceName *name in names) {
                       printf("%s\n", name.description.UTF8String);
                   }
               }];
 
 An example output of one map resource is:
    name   : Frostgorge Sound
    id     : 30
 
 */
- (void)namesForResource:(NSString *)resource
              parameters:(NSDictionary *)parameters
              completion:(void (^)(NSError *error, NSArray *names))completion;


- (void)fetchRequestAtPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                completion:(void (^)(NSError *error, id result))completion;

#pragma mark - Shared daemon object
+ (instancetype)daemon;
@end
