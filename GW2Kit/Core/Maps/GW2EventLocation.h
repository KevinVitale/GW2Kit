//
//  GW2MapLocation.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2Object.h"

#if TARGET_OS_IPHONE
@import CoreGraphics;
#endif

@interface GW2EventLocation : GW2Object
@property (copy, nonatomic, readonly) NSString *type;
@property (copy, nonatomic, readonly) NSArray *center;
@property       (nonatomic, readonly) CGSize zRange;
@property (copy, nonatomic, readonly) NSArray *points;
@property       (nonatomic, readonly) CGFloat height;
@property       (nonatomic, readonly) CGFloat radius;
@property       (nonatomic, readonly) CGFloat rotation;
@end
