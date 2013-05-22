//
//  GW2RecipeDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2RecipeDetail : NSObject

@property (copy, nonatomic) NSString *recipeID;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *outputItemID;
@property (copy, nonatomic) NSString *outputItemCount;
@property (copy, nonatomic) NSString *minimumRating;
@property (copy, nonatomic) NSNumber *timeToCraft;
@property (copy, nonatomic) NSArray  *ingredients;

+ (RKObjectMapping *)mappingObject;
@end
