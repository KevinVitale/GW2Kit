//
//  GW2RecipeSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/11/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2Recipe.h"

SpecBegin(GW2Recipe)

describe(@"recipe", ^ {
    NSDictionary *__block recipeDetailJSON;
    beforeAll(^ {
        NSURL *recipeJSONURL = [[NSBundle bundleForClass:self.class] URLForResource:@"recipe_details" withExtension:@"json"];
        recipeDetailJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:recipeJSONURL] options:0 error:nil];
        expect(recipeDetailJSON).toNot.beNil();
    });
    
    it(@"instantiates from JSON", ^ {
        id<GW2Recipe> recipe = [NSClassFromString(@"_GW2Recipe") objectWithID:nil
                                                                       name:nil
                                                         fromJSONDictionary:recipeDetailJSON
                                                                      error:nil];
        expect(recipe).toNot.beNil();
        expect(recipe.objectID).equal(1275);
        expect(recipe.name).equal(@"Coat");
        expect(recipe.outputItemID).equal(11541);
        expect(recipe.outputItemCount).equal(1);
        expect(recipe.timeToCraft).equal(1000);
        expect(recipe.disciplines).contain(@"Leatherworker");
        expect(recipe.flags.count).equal(0);
        expect([recipe.ingredients.firstObject conformsToProtocol:@protocol(GW2RecipeIngredient)]).to.beTruthy();
        expect([recipe.ingredients.firstObject count]).equal(1);
        expect(recipe.ingredients.count).equal(3);
    });
});
SpecEnd