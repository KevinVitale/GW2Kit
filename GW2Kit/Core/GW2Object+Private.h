//
//  GW2Object.h
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2Object.h"
#import <Mantle/Mantle.h>

/**
 *  Objects returned by the GW2 API which have an 'id' and a 'name'.
 *
 *  This includes:
 *      - event_names
 *      - world_names
 *      - map_naes
 *
 *  The response looks like:
 *      {
 *          "name"  : " ... ",
 *          "id"    : " ... "
 *      }
 *
 *  The value of 'name' can be a string, in the case of events.
 *  The value of 'name' can be a number, in the case of world and maps.
 */
@interface _GW2Object : MTLModel <MTLManagedObjectSerializing, MTLJSONSerializing, GW2Object>
/*
 *  @property objectID
 *  @property name;
 */
@end