//
//  GW2NameObjectSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2Object.h"

SpecBegin(GW2Object)

id __block eventNamesJSON;
id __block mapNamesJSON;
id __block worldNamesJSON;

describe(@"named object", ^ {
    beforeAll(^ {
        NSURL *eventNamesURL = [[NSBundle bundleForClass:self.class] URLForResource:@"event_names" withExtension:@"json"];
        expect(eventNamesURL).toNot.beNil();
        eventNamesJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:eventNamesURL] options:0 error:nil];
        expect(eventNamesJSON).toNot.beNil();
        expect([eventNamesJSON class]).to.beSubclassOf([NSArray class]);
        
        NSURL *mapNamesURL = [[NSBundle bundleForClass:self.class] URLForResource:@"map_names" withExtension:@"json"];
        expect(mapNamesURL).toNot.beNil();
        mapNamesJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:mapNamesURL] options:0 error:nil];
        expect(mapNamesJSON).toNot.beNil();
        expect([mapNamesJSON class]).to.beSubclassOf([NSArray class]);
        
        NSURL *worldNamesURL = [[NSBundle bundleForClass:self.class] URLForResource:@"world_names" withExtension:@"json"];
        expect(worldNamesURL).toNot.beNil();
        worldNamesJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:worldNamesURL] options:0 error:nil];
        expect(worldNamesJSON).toNot.beNil();
        expect([worldNamesJSON class]).to.beSubclassOf([NSArray class]);
    });
    
    it(@"works with event names", ^ {
        GW2Object *nameObject = [MTLJSONAdapter modelOfClass:[GW2Object class]
                                          fromJSONDictionary:[eventNamesJSON firstObject]
                                                       error:nil];
        // Ensure our object was created
        expect(nameObject).toNot.beNil();
        
        // Ensure the 'name' & 'objectID' match expected values
        expect(nameObject.name).to.equal(@"Aid those affected by Scarlet's attack on Divinity's Reach by donating to Ho-Ho-Tron.");
        expect(nameObject.objectID).to.equal(@"AD31D52F-C650-473D-8637-5792868828D7");
    });
    
    it(@"works with map names", ^ {
        GW2Object *nameObject = [MTLJSONAdapter modelOfClass:[GW2Object class]
                                          fromJSONDictionary:[mapNamesJSON firstObject]
                                                       error:nil];
        // Ensure our object was created
        expect(nameObject).toNot.beNil();
        
        // Ensure the 'name' & 'objectID' match expected values
        expect(nameObject.name).to.equal(@"Lion's Arch");
        expect(nameObject.objectID).to.equal(@"50");
    });
    
    it(@"works with world names", ^ {
        GW2Object *nameObject = [MTLJSONAdapter modelOfClass:[GW2Object class]
                                          fromJSONDictionary:[worldNamesJSON firstObject]
                                                       error:nil];
        // Ensure our object was created
        expect(nameObject).toNot.beNil();
        
        // Ensure the 'name' & 'objectID' match expected values
        expect(nameObject.name).to.equal(@"Jade Sea [FR]");
        expect(nameObject.objectID).to.equal(@"2101");
    });
    
    it(@"works with class initializers", ^ {
        GW2Object *nameObject = [GW2Object objectWithID:@10
                                                   name:@"Kevin"
                                     fromJSONDictionary:@{}
                                                  error:nil];
        expect(nameObject).toNot.beNil();
        expect(nameObject.objectID).equal(@10);
        expect(nameObject.name).equal(@"Kevin");
    });
    
    it(@"class initializer doesn't override default values", ^ {
        GW2Object *nameObject = [GW2Object objectWithID:@10
                                                   name:@"Kevin"
                                     fromJSONDictionary:@{@"id" : @20, @"name" : @"Owen"}
                                                  error:nil];
        expect(nameObject).toNot.beNil();
        expect(nameObject.objectID).equal(@20);
        expect(nameObject.name).equal(@"Owen");
    });
});
SpecEnd