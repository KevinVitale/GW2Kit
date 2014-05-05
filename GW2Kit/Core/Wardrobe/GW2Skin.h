//
//  GW2Skin.h
//  
//
//  Created by Kevin Vitale on 4/18/14.
//
//

#import "GW2Object.h"
#import "GW2IconFile.h"

#pragma mark - Skin Type
// -----------------------------------------------------------------------------
//  GW2SkinType, Protocol
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2SkinType
 *  @discussion The skin's type (@em "armor", or @em "weapon").
 */
@protocol GW2ArmorSkin <NSObject>
@required

/**
 *  @property   slot
 *  @discussion The slot of armor piece.
 */
@property (copy, nonatomic, readonly) NSString *slot;

/**
 *  @property   weight
 *  @discussion The armor's weight class: \"Light\", \"Medium\", \"Heavy\".
 */
@property (copy, nonatomic, readonly) NSString *weight;
@end

@protocol GW2WeaponSkin <NSObject>
@required
@property (copy, nonatomic, readonly) NSString *type;
@property (copy, nonatomic, readonly) NSString *element;
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
@property (copy, nonatomic, readonly)   NSString    *type;
@property (copy, nonatomic, readonly)   NSString    *optionalDescription;
@property (copy, nonatomic, readonly)   NSArray     *flags;
@property (copy, nonatomic, readonly)   NSArray     *restrictions;
@property (strong, nonatomic, readonly) id<GW2ArmorSkin>    armor;
@property (strong, nonatomic, readonly) id<GW2WeaponSkin>   weapon;
@end
