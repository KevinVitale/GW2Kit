//
//  GW2MapBasic.h
//  GW2Kit
//
//  Created by Kevin Vitale on 2/1/14.
//
//

#import "GW2Object.h"

#if TARGET_OS_IPHONE
@import CoreGraphics;
#endif

@protocol GW2MapBasic <GW2Object>
@property (assign, nonatomic, readonly) NSInteger   continentID;
@property   (copy, nonatomic, readonly) NSString    *continentName;
@property (assign, nonatomic, readonly) CGRect      continentRect;
@property (assign, nonatomic, readonly) NSInteger   defaultFloor;
@property   (copy, nonatomic, readonly) NSArray     *floors;
@property (assign, nonatomic, readonly) CGRect      frame;
@property (assign, nonatomic, readonly) NSUInteger  maxLevel;
@property (assign, nonatomic, readonly) NSUInteger  minLevel;
@property (assign, nonatomic, readonly) NSInteger   regionID;
@property   (copy, nonatomic, readonly) NSString    *regionName;
@end
