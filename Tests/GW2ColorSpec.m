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
        GW2Color *color = [MTLJSONAdapter modelOfClass:[GW2Color class]
                                    fromJSONDictionary:colorsDictionary[@"1"]
                                                 error:nil];
        // Check object integrity
        expect(color).toNot.beNil();
        expect(color.color).toNot.beNil();
        
        // Are we able to construct the original JSON from our object?
        id colorJSON = [MTLJSONAdapter JSONDictionaryFromModel:color];
        NSDictionary *colorToCompare = colorsDictionary[@"1"];
        expect([colorJSON hash]).equal(colorToCompare.hash);
    });
    
    it(@"instantiates from color material JSON", ^ {
        GW2ColorMaterial *colorMaterial = [MTLJSONAdapter modelOfClass:[GW2ColorMaterial class]
                                                    fromJSONDictionary:colorsDictionary[@"1"][@"cloth"]
                                                                 error:nil];
        // Check object integrity
        expect(colorMaterial).toNot.beNil();
        expect(colorMaterial.color).toNot.beNil();
        
        // Are we able to construct the original JSON from our object?
        id colorMaterialJSON = [MTLJSONAdapter JSONDictionaryFromModel:colorMaterial];
        NSDictionary *colorMaterialToCompare = colorsDictionary[@"1"][@"cloth"];
        expect([colorMaterialJSON hash]).equal(colorMaterialToCompare.hash);
   });
});
SpecEnd