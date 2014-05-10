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

/**
 *  Loads a spec file for the given the name.
 *
 *  @param  file The spec's file name.
 *  @return A JSON object for the contents of @p file.
 */
id GW2SpecLoadJSONFixture(NSString *file) {
    NSBundle *bundle    = [NSBundle bundleForClass:GW2SharedSpec.class];
    NSURL *URL          = [bundle URLForResource:file withExtension:@"json"];
    NSData *jsonData    = [NSData dataWithContentsOfURL:URL];
    id JSON             = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    
    return JSON;
}