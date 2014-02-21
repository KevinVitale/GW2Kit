//
//  GW2ColorSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2Color.h"

SpecBegin(GW2Color)
describe(@"color", ^ {
    NSDictionary *__block colorsDictionary;
    beforeAll(^ {
        // Pull the .json file from the bundle
        NSURL *colorsURL = [[NSBundle bundleForClass:self.class] URLForResource:@"colors" withExtension:@"json"];
        expect(colorsURL).toNot.beNil();
        
        // Convert it to an NSObject
        id colorsJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:colorsURL] options:0 error:nil];
        
        // Verify a few basic things
        expect(colorsJSON).toNot.beNil();
        expect([colorsJSON class]).to.beSubclassOf([NSDictionary class]);
        
        // Extract the array of event states
        colorsDictionary = colorsJSON[@"colors"];
        expect(colorsDictionary.count).toNot.beNil();
    });
    
    it(@"instantiates from color JSON", ^ {
        id<GW2Color> color = [NSClassFromString(@"_GW2Color") objectWithID:@1
                                                                      name:nil
                                                        fromJSONDictionary:colorsDictionary[@"1"]
                                                                     error:nil];
        // Check object integrity
        expect(color).toNot.beNil();
        expect(color.name).equal(@"Dye Remover");
        expect(color.color).toNot.beNil();
        expect(color.cloth).toNot.beNil();
        expect(color.leather).toNot.beNil();
        expect(color.metal).toNot.beNil();
        
#if TARGET_OS_IPHONE
        Class colorClass = NSClassFromString(@"UIColor");
#else
        Class colorClass = NSClassFromString(@"NSColor");
#endif
        expect([color.color isKindOfClass:colorClass]).to.beTruthy();
        expect([color.cloth conformsToProtocol:@protocol(GW2ColorMaterial)]).to.beTruthy();
        expect(color.objectID).equal(1);

        
        // Are we able to construct the original JSON from our object?
        id colorJSON = [color JSONRepresentation];
        NSDictionary *colorToCompare = colorsDictionary[@"1"];
        expect([colorJSON hash]).equal(colorToCompare.hash);
    });
    
    it(@"instantiates from color material JSON", ^ {
        id<GW2ColorMaterial> colorMaterial = [NSClassFromString(@"_GW2ColorMaterial") objectWithID:nil
                                                                                              name:nil
                                                                                fromJSONDictionary:colorsDictionary[@"1"][@"cloth"]
                                                                                             error:nil];
        // Check object integrity
        expect(colorMaterial).toNot.beNil();
        expect(colorMaterial.color).toNot.beNil();
        
        // Are we able to construct the original JSON from our object?
        id colorMaterialJSON = [colorMaterial JSONRepresentation];
        NSDictionary *colorMaterialToCompare = colorsDictionary[@"1"][@"cloth"];
        expect([colorMaterialJSON hash]).equal(colorMaterialToCompare.hash);
   });
});
SpecEnd