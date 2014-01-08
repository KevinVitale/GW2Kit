//
//  GW2WvWMatchUpSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/8/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2WvWMatchUp.h"

SpecBegin(GW2WvWMatchUp)
describe(@"wvw match ups", ^ {
    NSDictionary *__block matchesJSON;
    GW2WvWMatchUp *__block matchUp;
    beforeAll(^ {
        // Pull the .json file from the bundle
        NSURL *matchDetailsURL = [[NSBundle bundleForClass:self.class] URLForResource:@"matches" withExtension:@"json"];
        expect(matchDetailsURL).toNot.beNil();
        
        // Convert it to an NSObject
        matchesJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:matchDetailsURL] options:0 error:nil];
        
        // Verify a few basic things
        expect(matchesJSON).toNot.beNil();
        expect([matchesJSON class]).to.beSubclassOf([NSDictionary class]);
    });
    
    beforeEach(^ {
        NSArray *matchesArray = matchesJSON[@"wvw_matches"];
        expect(matchesArray.count).equal(17);
        matchUp = [GW2WvWMatchUp objectWithID:nil
                                         name:nil
                           fromJSONDictionary:matchesArray.firstObject
                                        error:nil];
    });
    
    it(@"instantiates matches from JSON", ^ {
        // Check object integrity
        expect(matchUp).toNot.beNil();
        expect(matchUp.objectID).equal(@"2-1");
        expect(matchUp.greenWorldID).equal(2012);
        expect(matchUp.blueWorldID).equal(2010);
        expect(matchUp.redWorldID).equal(2201);
        expect(matchUp.startDate).to.beKindOf(NSDate.class);
        expect(matchUp.endDate).to.beKindOf(NSDate.class);
   });
});
SpecEnd
