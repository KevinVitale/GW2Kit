//  GW2Kit Tests
//
//  Created by Kevin Vitale on 3/29/14.
//
//

#pragma mark - TDD Headers
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <GW2Kit/GW2Kit.h>
#import <ReactiveCocoa.h>

extern NSURL*   GW2URLForResourceFile(NSString *file, NSString *extension);
extern id       GW2SpecLoadJSONFixture(NSString *file);