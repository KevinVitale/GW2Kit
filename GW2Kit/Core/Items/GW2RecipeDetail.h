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

@property (copy, nonatomic) NSNumber *id;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSNumber *outputItemID;
@property (copy, nonatomic) NSNumber *outputItemCount;
@property (copy, nonatomic) NSNumber *minimumRating;
@property (copy, nonatomic) NSNumber *timeToCraft;
@property (copy, nonatomic) NSArray  *ingredients;
@property (copy, nonatomic) NSArray  *flags;
@property (copy, nonatomic) NSArray  *disciplines;

+ (RKObjectMapping *)mappingObject;
@end
