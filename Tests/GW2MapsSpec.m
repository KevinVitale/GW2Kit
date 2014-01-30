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

#import "GW2MapRegion.h"

SpecBegin(GW2Maps)
describe(@"maps", ^ {
    NSDictionary *__block maps;
    beforeAll(^ {
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.guildwars2.com/v1/maps.json"]];
        maps = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        expect(maps).toNot.beNil();
    });
    
    it(@"should do something", ^ {
        
    });
});
SpecEnd
