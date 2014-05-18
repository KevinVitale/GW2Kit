//
//  GW2WvWMatchUpSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/8/14.
//
//

#import "GW2SharedSpec.h"
#import "GW2WvWMatchUp.h"

SpecBegin(GW2WvWMatchUp)
describe(@"wvw match ups", ^ {
    NSDictionary *__block matchesJSON;
    id<GW2WvWMatchUp> __block matchUp;
    beforeAll(^ {
        // Convert it to an NSObject
        matchesJSON = GW2SpecLoadJSONFixture(@"matches");
        
        // Verify a few basic things
        expect([matchesJSON count]).to.beGreaterThan(0);
        expect([matchesJSON class]).to.beSubclassOf([NSDictionary class]);
    });
    
    beforeEach(^ {
        NSArray *matchesArray = matchesJSON[@"wvw_matches"];
        expect(matchesArray.count).equal(17);
        matchUp = [NSClassFromString(@"_GW2WvWMatchUp") objectWithID:nil
                                                               name:nil
                                                 fromJSONDictionary:matchesArray.firstObject
                                                              error:nil];
    });
    
    it(@"instantiates matches from JSON", ^ {
        // Check object integrity
        expect(matchUp).toNot.beNil();
        expect(matchUp.id).equal(@"2-1");
        expect(matchUp.greenWorldID).equal(2012);
        expect(matchUp.blueWorldID).equal(2010);
        expect(matchUp.redWorldID).equal(2201);
        expect(matchUp.startDate).to.beKindOf(NSDate.class);
        expect(matchUp.endDate).to.beKindOf(NSDate.class);
   });
});
SpecEnd
