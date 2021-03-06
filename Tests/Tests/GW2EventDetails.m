//
//  GW2EventDetails.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2SharedSpec.h"
#import "GW2Event.h"
#import "GW2EventLocation.h"

SpecBegin(GW2EventDetails)
describe(@"event details", ^ {
    NSString *eventID = @"CEA84FBF-2368-467C-92EA-7FA60D527C7B";
    NSDictionary *__block eventDetailsDictionary;
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
        
        eventDetailsDictionary = @
        {
            @"name"     : @"Find a way to open the door and escape the armory.",
            @"level"    : @8,
            @"map_id"   : @19,
            @"flags"    : @[@"group_event"],
            @"location" : locationDictionary
        };
    });
    
    it(@"instantiates from JSON", ^ {
        id<GW2Event> event = [NSClassFromString(@"_GW2Event") objectWithID:eventID
                                                                      name:nil
                                                        fromJSONDictionary:eventDetailsDictionary
                                                                     error:nil];
        expect(event).toNot.beNil();
        expect(event.id).equal(eventID);
        expect(event.location).toNot.beNil();
        expect(event.mapID).equal(19);
        expect(event.flags.firstObject).equal(@"group_event");
        expect([event.location conformsToProtocol:@protocol(GW2EventLocation)]).to.beTruthy();
        
        id EventJSON = [event JSONRepresentation];
        expect([EventJSON hash]).equal(eventDetailsDictionary.hash);
    });
});
SpecEnd
