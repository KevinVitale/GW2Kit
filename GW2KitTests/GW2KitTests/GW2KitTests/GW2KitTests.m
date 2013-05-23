//
//  GW2KitTests.m
//  GW2KitTests
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2KitTests.h"
#import <GW2Kit/GW2Kit.h>

#pragma mark - Resource Counts
static NSUInteger g_ExpectedMapCount            = 26;
static NSUInteger g_ExpectedEventCount          = 0;
static NSUInteger g_ExpectedWorldCount          = 0;
static NSUInteger g_ExpectedWvWObjectivesCount  = 0;

@implementation GW2KitTests

+ (void)initialize {
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
}


#pragma mark - Setup/TearDown
- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}
- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark - Items
- testEpicFail {
    STFail(@"Tests are broken, at the moment.");
}
@end