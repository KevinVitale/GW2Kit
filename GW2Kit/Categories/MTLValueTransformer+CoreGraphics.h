//
//  MTLValueTransformer+NSArray.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/5/14.
//
//

@class MTLValueTransformer;

MTLValueTransformer* MTLReversibleRectTransformer(NSInteger precision);
MTLValueTransformer* MTLReversibleSizeTransformer(NSInteger precision);
MTLValueTransformer* MTLReversiblePointTransformer(NSInteger precision);

/*
 * For some screwy reason, I couldn't get a category on this class to work.
    @interface MTLValueTransformer (CoreGraphics)
        + (instancetype)reversibleSizeTransformer;
@end
 */