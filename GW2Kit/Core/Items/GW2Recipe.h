//
//  GW2Recipe.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/11/14.
//
//

#import "GW2Object.h"

@protocol GW2RecipeIngredient <GW2Object>
@property (nonatomic, readonly) NSInteger count;
@end

@protocol GW2Recipe <GW2Object>
@property       (nonatomic, readonly) NSInteger outputItemID;
@property       (nonatomic, readonly) NSInteger outputItemCount;
@property       (nonatomic, readonly) NSInteger minimumRating;
@property       (nonatomic, readonly) NSTimeInterval timeToCraft;
@property (copy, nonatomic, readonly) NSArray *disciplines;
@property (copy, nonatomic, readonly) NSArray *flags;
@property (copy, nonatomic, readonly) NSArray *ingredients;
@end
