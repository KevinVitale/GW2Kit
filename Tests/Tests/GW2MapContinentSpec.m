//
//  GW2NameObjectSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//


#import "GW2SharedSpec.h"
#import "GW2MapContinent.h"

SpecBegin(GW2MapContinent)

describe(@"map continent", ^ {
    id __block continentsJSON;

    beforeAll(^ {
        continentsJSON = GW2SpecLoadJSONFixture(@"continents");
        expect([continentsJSON count]).to.beGreaterThan(0);
        expect([continentsJSON class]).to.beSubclassOf([NSDictionary class]);
    });
    
    it(@"works with API response", ^ {
        id TyriaContinent = continentsJSON[@"continents"][@"1"];
        id<GW2MapContinent> mapContinent = [NSClassFromString(@"_GW2MapContinent") objectWithID:@1
                                                                                           name:nil
                                                                             fromJSONDictionary:TyriaContinent
                                                                                          error:nil];
        // Ensure our object was created from Tyria
        expect(mapContinent).toNot.beNil();
        expect(mapContinent.objectID).equal(@1);
        expect(mapContinent.name).equal(@"Tyria");
        expect(CGSizeEqualToSize(mapContinent.size, CGSizeMake((CGFloat)32768, (CGFloat)32768))).to.beTruthy();
        
        // Make sure the JSON matches the original input
        id TyriaJSON = [mapContinent JSONRepresentation];
        expect(TyriaJSON).equal(TyriaContinent);
        
        // Let's switch over to Heart of the Mists
        id HoMContinent = continentsJSON[@"continents"][@"2"];
        mapContinent = [NSClassFromString(@"_GW2MapContinent") objectWithID:@2
                                                                       name:nil
                                                         fromJSONDictionary:HoMContinent
                                                                      error:nil];
        
        // Ensure our object was created from HoM
        expect(mapContinent).toNot.beNil();
        expect(mapContinent.objectID).equal(@2);
        expect(mapContinent.name).equal(@"Mists");
        
        // Make sure the JSON matches the original input
        id HoMJSON = [mapContinent JSONRepresentation];
        expect(HoMJSON).equal(HoMContinent);
    });
});
SpecEnd