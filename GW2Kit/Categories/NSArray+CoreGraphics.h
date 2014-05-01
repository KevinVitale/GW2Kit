//
//  NSArray+CoreGraphics.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/5/14.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (CoreGraphics)
/*	Create a CGPoint from an NSArray.
 *
 *  @dicussion
 *	The array format:
 *		@[ @20.1, @5.5 ]
 *
 *	converts to the point:
 *		{ 20.1, 5.5 }
 *
 *	@param precision The decimal precision for both coordinate values.
 *
 *	@return A @p CGPoint (using @em double values when compiled on 64-bit systems).
 */
- (CGPoint)point:(NSInteger)precision;

- (CGSize)size:(NSInteger)precision;
- (CGRect)rect:(NSInteger)precision;
@end