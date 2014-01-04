//
//  GW2EventStateSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2EventState.h"

SpecBegin(GW2EventState)
describe(@"event state", ^ {
    NSArray *__block eventStatesArray;
    
    beforeAll(^ {
        // Pull the .json file from the bundle
        NSURL *eventsURL = [[NSBundle bundleForClass:self.class] URLForResource:@"events" withExtension:@"json"];
        expect(eventsURL).toNot.beNil();
        
        // Convert it to an NSObject
        id eventsJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:eventsURL] options:0 error:nil];
        
        // Verify a few basic things
        expect(eventsJSON).toNot.beNil();
        expect([eventsJSON class]).to.beSubclassOf([NSDictionary class]);
        
        // Extract the array of event states
        eventStatesArray = eventsJSON[@"events"];
        expect(eventStatesArray.count).toNot.beNil();
    });
    
    it(@"instantiates from JSON", ^ {
        GW2EventState *eventState = [GW2EventState objectWithID:nil
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
        id eventStateJSON = [MTLJSONAdapter JSONDictionaryFromModel:eventState];
        expect(eventStateJSON).equal(eventStatesArray.firstObject);
    });
});
SpecEnd