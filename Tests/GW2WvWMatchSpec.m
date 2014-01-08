//
//  GW2WvWMatchSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2WvWMatch.h"

SpecBegin(GW2WvWMatch)
describe(@"wvw match", ^ {
    NSDictionary *__block matchDetailsJSON;
    GW2WvWMatch *__block match;
    beforeAll(^ {
        // Pull the .json file from the bundle
        NSURL *matchDetailsURL = [[NSBundle bundleForClass:self.class] URLForResource:@"match_details" withExtension:@"json"];
        expect(matchDetailsURL).toNot.beNil();
        
        // Convert it to an NSObject
        matchDetailsJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:matchDetailsURL] options:0 error:nil];
        
        // Verify a few basic things
        expect(matchDetailsJSON).toNot.beNil();
        expect([matchDetailsJSON class]).to.beSubclassOf([NSDictionary class]);
    });
    
    beforeEach(^ {
        match = [GW2WvWMatch objectWithID:nil
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
        expect([match.battlegrounds valueForKey:@"class"]).to.contain(GW2WvWBattleground.class);
    });
    
    it(@"instantiates battlegrounds from JSON", ^ {
        GW2WvWBattleground *battleground = match.battlegrounds.firstObject;
        expect(battleground).toNot.beNil();
        
        expect(battleground.name).equal(@"RedHome");
        expect(battleground.scores.count).equal(3);
        expect(battleground.scores).to.contain(32338);
        expect(battleground.objectives.count).equal(18);
        expect([battleground.objectives valueForKey:@"guildID"]).contain(@"11CF64EB-F9AF-42DC-9D2D-17023AA9B1AB");
    });
});
SpecEnd