//
//  GW2MapLocationSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2MapLocation.h"

SpecBegin(GW2MapLocation)
describe(@"map location", ^ {
    NSDictionary *__block locationDictionary;
    beforeAll(^ {
        locationDictionary = @
        {
            @"height": @(2027.5),
            @"radius": @(10314.4),
            @"rotation": @(0),
            @"type": @"poly",
            @"center": @[
                         @(-45685.2),
                         @(-13819.6),
                         @(-1113)
                         ],
            @"z_range": @[
                          @(-2389),
                          @(163)
                          ],
            @"points": @[
                         @[
                             @(-49395.8),
                             @(-15845.5)
                             ],
                         @[
                             @(-42699.7),
                             @(-15794.1)
                             ],
                         @[
                             @(-43053),
                             @(-14081.4)
                             ],
                         @[
                             @(-43629.7),
                             @(-11725.4)
                             ],
                         @[
                             @(-49647.8),
                             @(-11651.7)
                             ]
                         ]
        };
    });
    
    it(@"instantiates from JSON", ^ {
        GW2MapLocation *location = [GW2MapLocation objectWithID:nil
                                                           name:nil
                                             fromJSONDictionary:locationDictionary
                                                          error:nil];
        expect(location).toNot.beNil();
        expect(location.type).equal(@"poly");
        expect(location.points.count).equal(5);
        expect(location.name).equal(nil);
        expect(location.objectID).equal(nil);
        
        id LocationJSON = [MTLJSONAdapter JSONDictionaryFromModel:location];
        expect([LocationJSON hash]).equal(locationDictionary.hash);
    });
});
SpecEnd