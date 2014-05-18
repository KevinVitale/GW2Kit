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
 *  Returns the @p NSURL for the resource file.
 *
 *  @param file      Name of the file.
 *  @param extension Extension of the file.
 *
 *  @return The @p NSURL for the file, or @p nil if it doesn't exist.
 */
NSURL* GW2URLForResourceFile(NSString *file, NSString *extension) {
    NSBundle *bundle    = [NSBundle bundleForClass:GW2SharedSpec.class];
    NSURL *URL          = [bundle URLForResource:file withExtension:extension];
    return URL;
}

/**
 *  Loads a spec file for the given the name.
 *
 *  @param  file The spec's file name.
 *  @return A JSON object for the contents of @p file.
 */
id GW2SpecLoadJSONFixture(NSString *file) {
    NSURL *URL          = GW2URLForResourceFile(file, @"json");
    NSData *jsonData    = [NSData dataWithContentsOfURL:URL];
    id JSON             = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:0
                                                            error:nil];
    
    return JSON;
}