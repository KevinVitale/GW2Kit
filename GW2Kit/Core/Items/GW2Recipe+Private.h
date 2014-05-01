//
//  GW2Recipe+Private.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/11/14.
//
//

#import "GW2Recipe.h"
#import "GW2Object+Private.h"

@interface _GW2Recipe : _GW2Object <GW2Recipe>
@property       (nonatomic, readonly) NSInteger outputItemID;
@property       (nonatomic, readonly) NSInteger outputItemCount;
@property       (nonatomic, readonly) NSInteger minimumRating;
@property       (nonatomic, readonly) NSTimeInterval timeToCraft;
@property (copy, nonatomic, readonly) NSArray *disciplines;
@property (copy, nonatomic, readonly) NSArray *flags;
@property (copy, nonatomic, readonly) NSArray *ingredients;
@end