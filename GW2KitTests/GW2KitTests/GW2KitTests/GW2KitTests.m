//
//  GW2KitTests.m
//  GW2KitTests
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2KitTests.h"
#import <GW2Kit/GW2Kit.h>

@implementation GW2KitTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testItemDetail_Synchronously {
    NSString *itemID = @"29175";
    [GW2 itemDetailForID:itemID completion:^(NSError *error, GW2ItemDetail *itemDetail) {
        printf("\n\n\n%s\n\n\n", [itemDetail description].UTF8String);
        STAssertEqualObjects(itemID, itemDetail.itemID, @"ERROR: Item ID's do not match");
    }];
}

- (void)testEventStates_Synchronously {
    // Find event states in 'Kessex Hills' on 'Maguuma'
    [GW2 eventStatesWithParameters:@{@"world_id" : @"1005", @"map_id" : @"23"}
                        completion:^(NSError *error, id states) {
                            for(GW2EventStatus *status in states) {
                                printf("%s", [status description].UTF8String);
                            }
                            STAssertNotNil(states, @"ERROR: event states returned 'nil'");
                        }];
}
@end
