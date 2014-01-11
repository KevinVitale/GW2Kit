//
//  GW2Event.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2Object.h"
#import "GW2EventLocation.h"

@protocol GW2Event <GW2Object>
/**
 *  The event level.
 */
@property (nonatomic, readonly) NSInteger level;

/**
 *  The associated map where the event takes place.
 */
@property (nonatomic, readonly) NSInteger mapID;

/**
 *  Additional event flags. Possible values are:
 *    - group_event
 *    - map_wide
 */
@property (copy, nonatomic, readonly) NSArray *flags;

/**
 *  The location (actually, volume boundary) of the event. 
 *  See 'GW2EventLocation' for details.
 */
@property (nonatomic, readonly) id<GW2EventLocation> location;
@end
