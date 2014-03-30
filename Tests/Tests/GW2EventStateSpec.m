//
//  GW2EventStateSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#import "GW2SharedSpec.h"
#import "GW2EventState.h"

SpecBegin(GW2EventState)
describe(@"event state", ^ {
    NSArray *__block eventStatesArray;
    
    beforeAll(^ {
        // Extract the array of event states
        eventStatesArray = GW2SpecLoadJSONFixture(@"events")[@"events"];
        expect(eventStatesArray.count).to.beGreaterThan(0);
    });
    
    it(@"instantiates from JSON", ^ {
        id<GW2EventState> eventState =
        [NSClassFromString(@"_GW2EventState") objectWithID:nil
                                                      name:@"Stop the skritt burglar before it escapes with the treasure."
                                        fromJSONDictionary:eventStatesArray.firstObject
                                                     error:nil];
        // Check object integrity
        expect(eventState).toNot.beNil();
        expect(eventState.state).equal(@"Warmup");
        expect(eventState.worldID).equal(@1001);
        expect(eventState.mapID).equal(@39);
        expect(eventState.objectID).equal(@"2875FBFE-668E-438A-8CE7-A4BCF2EF0175");
        expect(eventState.name).equal(@"Stop the skritt burglar before it escapes with the treasure.");
        
        // Turn back into JSON
        id eventStateJSON = [eventState JSONRepresentation];
        expect(eventStateJSON).equal(eventStatesArray.firstObject);
    });
});
SpecEnd