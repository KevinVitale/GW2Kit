//
//  GW2ColorSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#import "GW2SharedSpec.h"
#import "GW2Color.h"
#import <ReactiveCocoa.h>

SpecBegin(GW2Color)
describe(@"color", ^ {
    NSArray *__block colors;
    beforeAll(^ {
        
        colors = ({
            // Convert it to an NSObject
            id colorsJSON = GW2SpecLoadJSONFixture(@"colors")[@"colors"];
            
            
            // Extract the array of colors
            [[colorsJSON rac_sequence]
             map:^id(RACTuple *value) {
                 return
                 [NSClassFromString(@"_GW2Color") objectWithID:value[0]
                                                          name:nil
                                            fromJSONDictionary:value.second
                                                         error:nil];
             }].array;
        });
        
        expect(colors.count).toNot.beNil();
    });
    
    it(@"instantiates from color JSON", ^ {
        id<GW2Color> color = colors.firstObject;
        // Check object integrity
        expect(color).toNot.beNil();
        expect(color.name).equal(@"Brandywine");
        expect(color.color).toNot.beNil();
        expect(color.cloth).toNot.beNil();
        expect(color.leather).toNot.beNil();
        expect(color.metal).toNot.beNil();
        expect([color.cloth conformsToProtocol:@protocol(GW2ColorMaterial)]);
        expect([color.leather conformsToProtocol:@protocol(GW2ColorMaterial)]);
        expect([color.metal conformsToProtocol:@protocol(GW2ColorMaterial)]);
        
        
#if TARGET_OS_IPHONE
        Class colorClass = NSClassFromString(@"UIColor");
#else
        Class colorClass = NSClassFromString(@"NSColor");
#endif
        expect([color.color isKindOfClass:colorClass]).to.beTruthy();
        expect([color.cloth conformsToProtocol:@protocol(GW2ColorMaterial)]).to.beTruthy();
        expect(color.objectID).equal(@"441");
    });
});
SpecEnd