//
//  GW2SharedSpec.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 3/29/14.
//
//

@import XCTest;

@interface      GW2SharedSpec : XCTest; @end
@implementation GW2SharedSpec           @end

id GW2SpecLoadJSONFixture(NSString *file) {
    NSBundle *bundle    = [NSBundle bundleForClass:GW2SharedSpec.class];
    NSURL *URL          = [bundle URLForResource:file withExtension:@"json"];
    NSData *jsonData    = [NSData dataWithContentsOfURL:URL];
    id JSON             = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    return JSON;
}