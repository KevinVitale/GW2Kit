//
//  GW2Skin.h
//  
//
//  Created by Kevin Vitale on 4/18/14.
//
//

#import "GW2Object.h"

#pragma mark - Skin Type
// -----------------------------------------------------------------------------
//  GW2SkinType, Protocol
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2SkinType
 *  @discussion The skin's type (@em "armor", or @em "weapon").
 */
@protocol GW2SkinType <GW2Object>
@required

/**
 *  @property   type
 */
@property (copy, nonatomic, readonly) NSString *type;

/**
 *  @property   weight
 */
@property (copy, nonatomic, readonly) NSString *weight;
@end

#pragma mark - Skin
// -----------------------------------------------------------------------------
//  GW2Skin, Protocol
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2Skin
 *  @discussion A collectable skin.
 */
@protocol GW2Skin <GW2Object, GW2IconFile>
@required
@property (copy, nonatomic, readonly) id<GW2SkinType> skinType;
@property (copy, nonatomic, readonly)         NSArray *flags;
@property (copy, nonatomic, readonly)         NSArray *restrictions;
@end
