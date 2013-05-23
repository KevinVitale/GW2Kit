//
//  AppDelegate.m
//  GW2TestiOSApp
//
//  Created by Kevin Vitale on 5/23/13.
//
//

#import "AppDelegate.h"
#import <GW2Kit/GW2Kit.h>

@interface AppDelegate ()
@property (copy, nonatomic) NSArray *events;
@property (copy, nonatomic) NSArray *eventNames;

@end


@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RKLogConfigureByName("RestKit/Network", RKLogLevelOff);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelOff);
    
    [GW2 namesForResource:@"event"
               parameters:nil
               completion:^(NSError *error, NSArray *names) {
                   self.eventNames = names;
                   [GW2 eventStatesWithParameters:@{
                    @"world_id" : @"1005",
                    @"map_id"   : @"28",
                    }
                                       completion:^(NSError *error, NSArray *states) {
                                           for(GW2EventStatus *status in states) {
                                               if([status.state isEqualToString:@"Active"]) {
                                                   if(names) {
                                                       self.events = states;
                                                       UITableViewController *tableViewController = [UITableViewController new];
                                                       tableViewController.tableView.delegate = self;
                                                       tableViewController.tableView.dataSource = self;
                                                       self.window.rootViewController = tableViewController;
                                                       [tableViewController.tableView reloadData];
                                                   }
                                               }
                                           }
                                       }];
               }];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    GW2EventStatus *event       = [self.events objectAtIndex:indexPath.row];
    GW2ResourceName *eventName  = [self.eventNames objectAtIndex:[[self.eventNames valueForKey:@"id"] indexOfObject:event.eventID]];
    cell.textLabel.text = [eventName name];
    cell.detailTextLabel.text = [event eventID];
    
    return cell;
}
@end
