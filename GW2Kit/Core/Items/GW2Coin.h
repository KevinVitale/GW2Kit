//
//  GW2Coin.h
//  
//
//  Created by Kevin Vitale on 5/11/14.
//
//

@import Foundation;

#pragma mark - Coin
// -----------------------------------------------------------------------------
//  GW2Coin
// -----------------------------------------------------------------------------
/**
 *  @class      GW2Coin
 *  @discussion Represents Tyrian currency and its denomination.
 */
@interface GW2Coin : NSObject

@end

#pragma mark - Category, String
// -----------------------------------------------------------------------------
//  Category, NSString - Coin
// -----------------------------------------------------------------------------
/**
 *  @category   GW2Coin
 *  @discussion Converts a integer string ("54231") into a coin value.
 */
@interface NSString (GW2Coin)

/**
 *  Converts the string to a coin object.
 *
 *  @return A @p GW2Coin instance.
 */
- (GW2Coin *)coinValue;
@end
