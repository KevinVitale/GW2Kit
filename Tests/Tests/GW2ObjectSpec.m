//
//  GW2NameObjectSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2SharedSpec.h"
#import "GW2Object.h"

SpecBegin(GW2Object)

id __block eventNamesJSON;
id __block mapNamesJSON;
id __block worldNamesJSON;

describe(@"named object", ^ {
    beforeAll(^ {
        eventNamesJSON = GW2SpecLoadJSONFixture(@"event_names");
        expect([eventNamesJSON count]).to.beGreaterThan(0);
        expect([eventNamesJSON class]).to.beSubclassOf([NSArray class]);
        
        mapNamesJSON = GW2SpecLoadJSONFixture(@"map_names");
        expect([mapNamesJSON count]).to.beGreaterThan(0);
        expect([mapNamesJSON class]).to.beSubclassOf([NSArray class]);
        
        worldNamesJSON = GW2SpecLoadJSONFixture(@"world_names");
        expect([worldNamesJSON count]).to.beGreaterThan(0);
        expect([worldNamesJSON class]).to.beSubclassOf([NSArray class]);
    });
    
    it(@"works with event names", ^ {
        id<GW2Object> nameObject =
        [NSClassFromString(@"_GW2Object") objectWithID:nil
                                                  name:nil
                                    fromJSONDictionary:[eventNamesJSON firstObject]
                                                 error:nil];
        // Ensure our object was created
        expect(nameObject).toNot.beNil();
        
        // Ensure the 'name' & 'objectID' match expected values
        expect(nameObject.name).to.equal(@"Aid those affected by Scarlet's attack on Divinity's Reach by donating to Ho-Ho-Tron.");
        expect(nameObject.id).to.equal(@"AD31D52F-C650-473D-8637-5792868828D7");
    });
    
    it(@"works with map names", ^ {
        id<GW2Object> nameObject =
        [NSClassFromString(@"_GW2Object") objectWithID:nil
                                                  name:nil
                                    fromJSONDictionary:[mapNamesJSON firstObject]
                                                 error:nil];
        // Ensure our object was created
        expect(nameObject).toNot.beNil();
        
        // Ensure the 'name' & 'objectID' match expected values
        expect(nameObject.name).to.equal(@"Lion's Arch");
        expect(nameObject.id).to.equal(@"50");
    });
    
    it(@"works with world names", ^ {
        id<GW2Object> nameObject =
        [NSClassFromString(@"_GW2Object") objectWithID:nil
                                                  name:nil
                                    fromJSONDictionary:[worldNamesJSON firstObject]
                                                 error:nil];
        // Ensure our object was created
        expect(nameObject).toNot.beNil();
        
        // Ensure the 'name' & 'objectID' match expected values
        expect(nameObject.name).to.equal(@"Jade Sea [FR]");
        expect(nameObject.id).to.equal(@"2101");
    });
    
    it(@"works with class initializers", ^ {
        id<GW2Object> nameObject = [NSClassFromString(@"_GW2Object") objectWithID:@10
                                                                             name:@"Kevin"
                                                               fromJSONDictionary:@{}
                                                                            error:nil];
        expect(nameObject).toNot.beNil();
        expect(nameObject.id).equal(@10);
        expect(nameObject.name).equal(@"Kevin");
    });
    
    it(@"class initializer doesn't override default values", ^ {
        id<GW2Object> nameObject =
        [NSClassFromString(@"_GW2Object") objectWithID:@10
                                                  name:@"Kevin"
                                    fromJSONDictionary:@{@"id" : @20, @"name" : @"Owen"}
                                                 error:nil];
        expect(nameObject).toNot.beNil();
        expect(nameObject.id).equal(@20);
        expect(nameObject.name).equal(@"Owen");
    });
});
SpecEnd