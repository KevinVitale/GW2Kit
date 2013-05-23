//
//  AppDelegate.m
//  GW2TestOSXApp
//
//  Created by Kevin Vitale on 5/22/13.
//
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    RKLogConfigureByName("RestKit/Network", RKLogLevelOff);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelOff);

    [GW2 namesForResource:@"event"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   
                   [GW2 eventStatesWithParameters:@{
                    @"world_id" : @"1005",
                    @"map_id"   : @"28",
                    }
                                       completion:^(NSError *error, NSArray *states) {
                                           for(GW2EventStatus *status in states) {
                                               if([status.state isEqualToString:@"Active"]) {
                                                   if(names) {
                                                       NSUInteger index = [[names valueForKey:@"id"] indexOfObject:status.eventID];
                                                       printf("%s\n", [[names objectAtIndex:index] description].UTF8String);
                                                   }
                                                   else {
                                                       printf("%s\n", status.description.UTF8String);
                                                   }
                                               }
                                           }
                                       }];
               }];
}

@end
