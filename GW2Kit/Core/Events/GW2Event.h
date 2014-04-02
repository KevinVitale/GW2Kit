//
//  GW2Event.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2Object.h"

@protocol GW2EventLocation;

#pragma mark - GW2 Event
// -----------------------------------------------------------------------------
//  GW2Event
// -----------------------------------------------------------------------------
@protocol GW2Event <GW2Object>
/**
 *  @property   level
 *  @discussion The event level.
 */
@property (nonatomic, readonly) NSInteger level;

/**
 *  @property   mapID
 *  @discussion The associated map where the event takes place.
 */
@property (nonatomic, readonly) NSInteger mapID;

/**
 *  @property   flags
 *  @discussion Optional event flags.
 *
 *  @note Additional event flags. Possible values are:
 *          @p group_event,
 *          @p map_wide
 */
@property (copy, nonatomic, readonly) NSArray *flags;

/**
 *  @property   location
 *  @discussion The location (actually, volume boundary) of the event.
 *  See 'GW2EventLocation' for details.
 */
@property (nonatomic, readonly) id<GW2EventLocation> location;
@end
