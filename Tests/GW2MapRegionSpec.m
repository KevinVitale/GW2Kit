//
//  GW2MapRegionSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/6/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2MapRegion.h"

SpecBegin(GW2MapRegion)

id __block mapFloorJSON;
id __block ShiverpeakMountainsJSON;
GW2MapRegion __block *mapRegion;

describe(@"map floor", ^ {
    beforeAll(^ {
        NSURL *mapContinentURL = [[NSBundle bundleForClass:self.class] URLForResource:@"map_floor" withExtension:@"json"];
        expect(mapContinentURL).toNot.beNil();
        mapFloorJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:mapContinentURL] options:0 error:nil];
        expect(mapFloorJSON).toNot.beNil();
        expect([mapFloorJSON class]).to.beSubclassOf([NSDictionary class]);
        
        ShiverpeakMountainsJSON = mapFloorJSON[@"regions"][@"1"];
        NSError *error;
        mapRegion = [GW2MapRegion objectWithID:@1
                                          name:nil
                            fromJSONDictionary:ShiverpeakMountainsJSON
                                         error:&error];
        NSLog(@"%@", error);
    });
    
    it(@"map region with API response", ^ {
        
        // Ensure our object was created from Tyria
        expect(mapRegion).toNot.beNil();
        expect(mapRegion.objectID).equal(@1);
        expect(mapRegion.name).equal(@"Shiverpeak Mountains");
        
        expect(mapRegion.subregions.count).equal(11);
        expect([mapRegion.subregions valueForKey:@"class"]).to.contain(GW2MapSubRegion.class);
        
        // Make sure the JSON matches the original input
        id RegionJSON = [MTLJSONAdapter JSONDictionaryFromModel:mapRegion];
        expect([RegionJSON hash]).equal([ShiverpeakMountainsJSON hash]);
    });
    
    it(@"map subregion with API response", ^ {
        GW2MapSubRegion *subregion = mapRegion.subregions.firstObject;
        expect(subregion.name).equal(@"Dredgehaunt Cliffs");
        
        id pointOfInterest = subregion.pointsOfInterest.firstObject;
        expect([pointOfInterest conformsToProtocol:@protocol(GW2MapSubRegionPointOfInterest)]).to.beTruthy();
        expect([(id<GW2MapSubRegionPointOfInterest>)pointOfInterest type]).equal(@"landmark");
        expect([(id<GW2MapSubRegionPointOfInterest>)pointOfInterest floor]).equal(1);
        expect([(id<GW2MapSubRegionPointOfInterest>)pointOfInterest objectID]).equal(1486);
        expect(CGPointEqualToPoint([pointOfInterest coordinate], CGPointMake((CGFloat)19760.9, (CGFloat)15379.5))).to.beTruthy();
        
        id poiJSON = [MTLJSONAdapter JSONDictionaryFromModel:pointOfInterest];
        expect(poiJSON).toNot.beNil();
        
        id task = subregion.tasks.firstObject;
        expect(task).toNot.beNil();
        expect([task name]).equal(@"Help Explorer Brokkar sabotage dredge munitions.");
        expect([task level]).equal(49);
        expect([task objectID]).equal(7);
        
        id TaskJSON = [MTLJSONAdapter JSONDictionaryFromModel:task];
        expect(TaskJSON).toNot.beNil();
        
        id sector = subregion.sectors.firstObject;
        expect([sector level]).equal(42);
        expect([sector objectID]).equal(532);
        expect([sector name]).equal(@"Wyrmblood Lake");
        expect([sector conformsToProtocol:@protocol(GW2MapSubRegionSector)]).to.beTruthy();
        expect(sector).toNot.beNil();
        
        id skillChallenge = subregion.skillChallenges.firstObject;
        expect(subregion.skillChallenges.count).equal(6);
        expect([skillChallenge conformsToProtocol:@protocol(GW2MapSubRegionSkillChallenge)]).to.beTruthy();
        expect(skillChallenge).toNot.beNil();
    });
});
SpecEnd