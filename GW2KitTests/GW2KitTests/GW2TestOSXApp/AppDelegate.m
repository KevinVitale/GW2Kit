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

    
    /*
    [GW2 namesForResource:@"event"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   for(GW2ResourceName *name in names) {
                       printf("%s\n", name.description.UTF8String);
                   }
               }];
     */
    
    /*
    [GW2 namesForResource:@"world"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   [names writeToFile:@"~/Desktop/world_names.plist" atomically:YES];
                   for(GW2ResourceName *name in names) {
                       printf("%s\n", name.description.UTF8String);
                   }
               }];
    
    [GW2 itemDetailForID:@"12345"
              completion:^(NSError *error, GW2ItemDetail *itemDetail) {
                  printf("%s", itemDetail.description.UTF8String);
              }];
    
    
    [GW2 namesForResource:@"map"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   [names writeToFile:@"~/Desktop/map_names.plist" atomically:YES];
                   for(GW2ResourceName *name in names) {
                       printf("%s\n", name.description.UTF8String);
                   }
               }];
     */
    
    /*
    [GW2 recipeDetailForID:@"1"
                parameters:nil
                completion:^(NSError *error, GW2RecipeDetail *recipeDetail) {
                    printf("%s", recipeDetail.description.UTF8String);
                }];
     */
    
    /*
    [GW2 itemsWithCompletion:^(NSError *error, NSArray *items) {
        printf("%s", [items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]].description.UTF8String);
    }];
     */
    
    /*
    [GW2 eventStatesWithParameters:@{@"world_id" : @"1005", @"map_id" : @"24"}
                        completion:^(NSError *error, NSArray *states) {
                            for(GW2EventStatus *status in states) {
                                if([status.state isEqualToString:@"Active"]) {
                                    printf("%s\n", [status description].UTF8String);
                                }
                            }
                        }];
     */
    
    /*
    [GW2 itemsWithCompletion:^(NSError *error, NSArray *items) {
        printf("%s\n", [items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]].description.UTF8String);
    }];
     */
    
    [GW2 namesForResource:@"map"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   for(GW2ResourceName *name in names) {
                       printf("%s\n", name.description.UTF8String);
                   }
               }];
    
    [GW2 namesForResource:@"event"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   
                   [GW2 eventStatesWithParameters:@{
                    @"world_id" : @"1005",
                    @"map_id" : @"28",
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

    /*
    [GW2 wvwMatchesWithCompletion:^(NSError *error, NSArray *matches) {
        for(GW2WvWMatch *match in matches) {
            printf("%s\n", match.description.UTF8String);
        }
    }];
    [GW2 wvwMatchDetailForID:@"2-1"
                  completion:^(NSError *error, GW2WvWMatchDetail *matchDetail) {
                      printf("%s", matchDetail.description.UTF8String);
                  }];
     */
    
    /*
    [[RACSignal merge:@[
      [GW2 namesForResource:@"map"
                 parameters:nil
                 completion:^(NSError *error, NSArray *names) {
                 }],
      [GW2 namesForResource:@"world"
                 parameters:nil
                 completion:^(NSError *error, NSArray *names) {
                 }]
      ]]
     subscribeNext:^(id x) {
         NSLog(@"%@", x);
     }
     completed:^{
        NSLog(@"Done");
    }];
     */
}

@end
