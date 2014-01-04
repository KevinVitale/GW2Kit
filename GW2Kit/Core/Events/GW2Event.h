//
//  GW2Event.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2Object.h"

@class GW2MapLocation;

@interface GW2Event : GW2Object
@property (nonatomic, readonly) NSInteger level;
@property (nonatomic, readonly) NSInteger mapID;
@property (copy, nonatomic, readonly) NSArray *flags;
@property (nonatomic, readonly) GW2MapLocation *location;
@end
