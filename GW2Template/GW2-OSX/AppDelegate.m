//
//  AppDelegate.m
//  GW2-OSX
//
//  Created by Kevin Vitale on 5/29/14.
//
//

#import "AppDelegate.h"
#import <GW2Kit/GW2Kit.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    id<GW2ClientV1> client = GW2ClientV1(nil);
    
    // Get all the event names, then for each one, get their details...
    [[[[client fetchEventNames]
        flattenMap:^RACStream *(id<GW2Object> eventName) {
            return [[client fetchEventDetails:[eventName id]] retry];
        }] logNext]
     subscribeCompleted:^{
         NSLog(@"Done");
     }];
    
    NSWindow *window = self.window;
    
    [[[[client fetchColors] take:1]
      doNext:^(id<GW2Color> color) {
          window.backgroundColor = [[color metal] color];
      }]
     subscribeCompleted:^{
     }];
}

@end
