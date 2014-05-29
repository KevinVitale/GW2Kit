//
//  AppDelegate.m
//  GW2-iOS
//
//  Created by Kevin Vitale on 5/29/14.
//
//

#import "AppDelegate.h"
#import <GW2Kit/GW2Kit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    id<GW2ClientV1> client = GW2ClientV1(nil);
    
    // Get all the event names, then for each one, get their details...
    [[[[client fetchEventNames]
       flattenMap:^RACStream *(id<GW2Object> eventName) {
           return [[client fetchEventDetails:[eventName id]] retry];
       }] logNext]
     subscribeCompleted:^{
         NSLog(@"Done");
     }];
    
    UIWindow *window = self.window;
    
    [[[[[client fetchColors] take:1]
      doNext:^(id<GW2Color> color) {
          window.backgroundColor = [[color metal] color];
      }]
     doError:^(NSError *error) {
         [[[UIAlertView alloc] initWithTitle:@"Oops..."
                                     message:@"There was a 'fetch' error"
                                    delegate:nil
                           cancelButtonTitle:@"Oh Well"
                           otherButtonTitles:nil]
          show];
     }]
     subscribeCompleted:^{
         NSLog(@"Done");
     }];

    return YES;
}
@end
