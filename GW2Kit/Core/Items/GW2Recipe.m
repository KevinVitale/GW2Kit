//
//  GW2Recipe.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/11/14.
//
//

#import "GW2Recipe+Private.h"


@interface _GW2RecipeIngredient : _GW2Object <GW2RecipeIngredient>
@property (nonatomic, readonly) NSInteger count;
@end

@implementation _GW2RecipeIngredient
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID" : @"item_id",
        @"name" : NSNull.null,
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end

@implementation _GW2Recipe
/**
 *  Transforms 'recipe_id' to 'reciepID'.
 *
 *  @return A new value transformer.
 *  @note The input comes in as NSString; the output as an NSNumber.
 */
+ (NSValueTransformer *)objectIDJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^id (id objectID) {
        id result;
        if([objectID isKindOfClass:NSString.class]) {
            result = @([objectID integerValue]);
        }
        else if([objectID isKindOfClass:NSNumber.class]) {
            result = [objectID stringValue];
        }
        return result;
    }];
}

+ (NSValueTransformer *)ingredientsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock: ^id (id ingredientObject) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[ingredientObject count]];
        for(id ingredient in ingredientObject) {
            if([ingredient isKindOfClass:NSDictionary.class]) {
                [mutableArray addObject:[_GW2RecipeIngredient objectWithID:nil
                                                                      name:nil
                                                        fromJSONDictionary:ingredient
                                                                     error:nil]];
            }
            else {
                [mutableArray addObject:[ingredient performSelector:@selector(JSONRepresentation)]];
            }
        }
        return [mutableArray copy];
    }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID" : @"recipe_id",
        @"name" : @"type",
        @"outputItemID" : @"output_item_id",
        @"outputItemCount" : @"output_item_count",
        @"minimumRating" : @"min_rating",
        @"timeToCraft" : @"time_to_craft_ms"
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}

@end