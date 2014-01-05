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

#import "GW2MapContinent.h"

SpecBegin(GW2MapContinent)

id __block continentsJSON;

describe(@"map continent", ^ {
    beforeAll(^ {
        NSURL *mapContinentURL = [[NSBundle bundleForClass:self.class] URLForResource:@"continents" withExtension:@"json"];
        expect(mapContinentURL).toNot.beNil();
        continentsJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:mapContinentURL] options:0 error:nil];
        expect(continentsJSON).toNot.beNil();
        expect([continentsJSON class]).to.beSubclassOf([NSDictionary class]);
    });
    
    it(@"works with API response", ^ {
        id TyriaContinent = continentsJSON[@"continents"][@"1"];
        GW2MapContinent *mapContinent = [GW2MapContinent objectWithID:@1
                                                                 name:nil
                                                   fromJSONDictionary:TyriaContinent
                                                                error:nil];
        // Ensure our object was created from Tyria
        expect(mapContinent).toNot.beNil();
        expect(mapContinent.objectID).equal(@1);
        expect(mapContinent.name).equal(@"Tyria");
        expect(CGSizeEqualToSize(mapContinent.size, CGSizeMake((CGFloat)32768, (CGFloat)32768))).to.beTruthy();
        
        // Make sure the JSON matches the original input
        id TyriaJSON = [MTLJSONAdapter JSONDictionaryFromModel:mapContinent];
        expect(TyriaJSON).equal(TyriaContinent);
        
        // Let's switch over to Heart of the Mists
        id HoMContinent = continentsJSON[@"continents"][@"2"];
        mapContinent = [GW2MapContinent objectWithID:@2
                                                name:nil
                                  fromJSONDictionary:HoMContinent
                                               error:nil];
        
        // Ensure our object was created from HoM
        expect(mapContinent).toNot.beNil();
        expect(mapContinent.objectID).equal(@2);
        expect(mapContinent.name).equal(@"Mists");
        
        // Make sure the JSON matches the original input
        id HoMJSON = [MTLJSONAdapter JSONDictionaryFromModel:mapContinent];
        expect(HoMJSON).equal(HoMContinent);
    });
});
SpecEnd