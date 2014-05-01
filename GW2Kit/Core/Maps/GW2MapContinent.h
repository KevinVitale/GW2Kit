//
//  GW2MapContinent.h
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2Object.h"
#if TARGET_OS_IPHONE
@import CoreGraphics;
#endif

@protocol GW2MapContinent <GW2Object>
@property (nonatomic, readonly) CGSize      size;
@property (nonatomic, readonly) NSInteger   minZoom;
@property (nonatomic, readonly) NSInteger   maxZoom;
@property (nonatomic, readonly) NSArray*    floors;
@end
