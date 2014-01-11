//
//  GW2EventState.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#import "GW2Object.h"

/**
 *  Event State Enums:
 *  
 *  Inactive    – The event is not running.
 *  Active      – The event is running now.
 *  Success     – The event has succeeded.
 *  Fail        – The event has failed.
 *  Warmup      – The event is inactive and waiting for certain criteria to be
 *                met before becoming Active.
 *  Preparation – The criteria for the event to start have been met, but certain
 *                activities (such as an NPC dialogue) have not completed yet. 
 *                After the activites have been completed, the event will become
 *                Active.
 */

@protocol GW2EventState <GW2Object>

/**
 *  Event state.
 */
@property (copy, nonatomic, readonly) NSString *state;

/**
 *  The map which this event state is associated with.
 */
@property (nonatomic, readonly) NSInteger mapID;

/**
 *  The world which this event state is associated with.
 */
@property (nonatomic, readonly) NSInteger worldID;
@end
