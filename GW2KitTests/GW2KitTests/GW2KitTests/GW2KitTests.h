//
//  GW2KitTests.h
//  GW2KitTests
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import <SenTestingKit/SenTestingKit.h>

#define LogTest() (printf("%s\n%s\n%s\n", "- - - - - - - - - - - - - - - - - - - - - -", __PRETTY_FUNCTION__, "- - - - - - - - - - - - - - - - - - - - - -"))

@interface GW2KitTests : SenTestCase

- (NSUInteger)countForResource:(NSString *)resource error:(NSError **)error;
@end
