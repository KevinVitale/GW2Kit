//
//  AppDelegate.m
//  GW2TestiOSApp
//
//  Created by Kevin Vitale on 5/23/13.
//
//

#import "AppDelegate.h"
#import <GW2Kit/GW2Kit.h>
#import <QuartzCore/QuartzCore.h>

@interface AppDelegate ()
@property (copy, nonatomic) NSArray *events;
@property (copy, nonatomic) NSArray *eventNames;
@property (copy, nonatomic) NSArray *colors;
@end


@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RKLogConfigureByName("RestKit/Network", RKLogLevelOff);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelOff);
    
    [GW2 colorsWithCompletion:^(NSError *error, NSArray *colors) {
        self.colors = colors;
        
        UITableViewController *tableViewController = [UITableViewController new];
        tableViewController.tableView.delegate = self;
        tableViewController.tableView.dataSource = self;
        self.window.rootViewController = tableViewController;
        [tableViewController.tableView reloadData];
    }];
    
    /*
    [GW2 recipeDetailForID:@"1"
                parameters:nil
                completion:^(NSError *error, GW2RecipeDetail *recipeDetail) {
                    printf("%s\n", recipeDetail.description.UTF8String);
                }];
     */
    
    /*
    [Spidy itemDetailForID:@"29175"
                completion:^(NSError *error, SPYItem *item) {
                    printf("%s\n", item.description.UTF8String);
                }];
     */
    
    /*
    [GW2 itemDetailForID:@"29175"
              completion:^(NSError *error, GW2ItemDetail *itemDetail) {
                  printf("%s\n", itemDetail.description.UTF8String);
              }];
     */
    
    /*
    [GW2 wvwMatchesWithCompletion:^(NSError *error, NSArray *matches) {
        for(GW2WvWMatch *match in matches) {
            printf("%s\n", match.description.UTF8String);
        }
    }];
     */
    
    /*
    [GW2 guildDetailWithParameters:@{@"guild_name" : @"New Tyria Order"}
                        completion:^(NSError *error, GW2GuildDetail *guildDetail) {
                            printf("%s\n", guildDetail.description.UTF8String);
                        }];
     */
    
    /*
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
     */
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.accessoryView = nil;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat rowHeight = tableView.rowHeight;
    
    GW2Color *color = self.colors[indexPath.row];
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100.f, rowHeight)];

    
    UIView *clothColor = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 33.33f, rowHeight)];
    clothColor.backgroundColor = color.clothMaterial.color;
    [colorView addSubview:clothColor];
    
    UIView *leatherColor = [[UIView alloc] initWithFrame:CGRectMake(33.f, 0.f, 33.33f, rowHeight)];
    leatherColor.backgroundColor = color.leatherMaterial.color;
    [colorView addSubview:leatherColor];
    
    UIView *metalColor = [[UIView alloc] initWithFrame:CGRectMake(66.f, 0.f, 33.33f, rowHeight)];
    metalColor.backgroundColor = color.metalMaterial.color;
    [colorView addSubview:metalColor];
    
    cell.clipsToBounds = YES;
    cell.accessoryView = colorView;
    colorView.backgroundColor = color.metalMaterial.color;
    cell.textLabel.text = color.name;
    
    cell.detailTextLabel.text = color.id;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}
@end
