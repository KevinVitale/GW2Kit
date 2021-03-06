//
//  GW2WvWMatchSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2SharedSpec.h"
#import "GW2WvWMatch.h"

SpecBegin(GW2WvWMatch)
describe(@"wvw match", ^ {
    NSDictionary *__block matchDetailsJSON;
    id<GW2WvWMatch> __block match;
    beforeAll(^ {
        // Convert it to an NSObject
        matchDetailsJSON = GW2SpecLoadJSONFixture(@"match_details");
        
        // Verify a few basic things
        expect([matchDetailsJSON count]).to.beGreaterThan(0);
        expect([matchDetailsJSON class]).to.beSubclassOf([NSDictionary class]);
    });
    
    beforeEach(^ {
        match = [NSClassFromString(@"_GW2WvWMatch") objectWithID:nil
                                                            name:nil
                                              fromJSONDictionary:matchDetailsJSON
                                                           error:nil];
    });
    
    it(@"instantiates from match details JSON", ^ {
        // Check object integrity
        expect(match).toNot.beNil();
        expect(match.scores).to.beKindOf(NSArray.class);
        expect(match.scores).to.contain(69514);
        expect(match.battlegrounds.count).equal(4);
        
        NSArray *battlegrounds = [match.battlegrounds valueForKey:@"class"];
        expect(battlegrounds).to.contain(NSClassFromString(@"_GW2WvWBattleground"));
    });
    
    it(@"instantiates battlegrounds from JSON", ^ {
        id<GW2WvWBattleground> battleground = match.battlegrounds.firstObject;
        expect(battleground).toNot.beNil();
        
        expect(battleground.name).equal(@"RedHome");
        expect(battleground.scores.count).equal(3);
        expect(battleground.scores).to.contain(32338);
        expect(battleground.objectives.count).equal(18);
        expect([battleground.objectives valueForKey:@"guildID"]).contain(@"11CF64EB-F9AF-42DC-9D2D-17023AA9B1AB");
    });
});
SpecEnd