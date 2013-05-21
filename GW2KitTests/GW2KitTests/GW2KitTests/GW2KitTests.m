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

- (void)testItems_Synchronously {
    [GW2 itemsWithCompletion:^(NSError *error, NSArray *items) {
        if(items.count > 5) {
            NSArray *firstFiveItems = [items objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]];
            printf("%s\n", firstFiveItems.description.UTF8String);
            printf("5 items out of %li\n\n", (unsigned long)items.count);
        }
        STAssertNotNil(items, @"ERROR: items returned 'nil'");
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

- (void)testMaps_Synchronously {
    [GW2 mapsWithParameters:nil completion:^(NSError *error, NSArray *maps) {
        for(GW2MapDetail *map in maps) {
            printf("%s", [map description].UTF8String);
        }
        STAssertNotNil(maps, @"ERROR: maps returned 'nil'");
    }];
}

- (void)testWorlds_Synchronously {
    [GW2 worldsWithParameters:nil completion:^(NSError *error, NSArray *worlds) {
        for(GW2WorldDetail *world in worlds) {
            printf("%s", [world description].UTF8String);
        }
        STAssertNotNil(worlds, @"ERROR: worlds returned 'nil'");
    }];
}

- (void)testWvwMatches_Synchronously {
    [GW2 wvwMatchesWithCompletion:^(NSError *error, NSArray *matches) {
        for(GW2WvWMatchDetail *match in matches) {
            printf("%s", [match description].UTF8String);
        }
        STAssertNotNil(matches, @"ERROR: WvW matches returned 'nil'");
    }];
}
@end
