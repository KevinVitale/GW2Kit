//
//  GW2MapsSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/30/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2MapBasic.h"

SpecBegin(GW2Maps)
describe(@"maps", ^ {
    NSDictionary *__block maps;
    beforeAll(^ {
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.guildwars2.com/v1/maps.json?map_id=15"]];
        maps = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        expect(maps).toNot.beNil();
    });
    
    it(@"should do something", ^ {
        NSError *error;
        id<GW2MapBasic> map = [NSClassFromString(@"_GW2MapBasic") objectWithID:@15
                                                                          name:nil
                                                            fromJSONDictionary:maps[@"maps"][@"15"]
                                                                         error:&error];
        expect(error).to.beNil();
        expect(map).toNot.beNil();
        expect([map objectID]).to.equal(15);
        expect([map name]).to.equal(@"Queensdale");
        expect([map continentName]).to.equal(@"Tyria");
        expect([map continentID]).to.equal(1);
        expect([map defaultFloor]).to.equal(1);
        expect([map maxLevel]).to.equal(17);
        expect([map minLevel]).to.equal(1);
        expect([map regionID]).to.equal(4);
        expect([map regionName]).to.equal(@"Kryta");
    });
});
SpecEnd
