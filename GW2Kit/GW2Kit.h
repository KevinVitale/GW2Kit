//
//  GW2Kit.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#pragma mark - Base Object
// -----------------------------------------------------------------------------
//  GW2Object
// -----------------------------------------------------------------------------
/*
 *  'GW2Object' is the base, top-level protocol for most all protocols in GW2Kit.
 *
 *  Map Names           --->                        /v1/map_names.json
 *  World Names         --->                        /v1/world_names.json
 *  Event Names         --->                        /v1/event_names.json
 *  WvW Objective Names --->                        /v1/wvw/objective_names.json
 */
#import "GW2Object.h"

#pragma mark - Clients
// -----------------------------------------------------------------------------
//  GW2Clients
// -----------------------------------------------------------------------------
/*
 *  'GW2Client' is a protocol that defines an interface for objects which
 *  connect to, and communicate with the GW2 APIs.
 *
 *  VERSION 1:
 *  Call 'GW2ClientV1()' to get a GW2 client that speaks with 'v1' of the API.
 */
#import "GW2Client.h"  /


#pragma mark - Events
// -----------------------------------------------------------------------------
//  GW2Events
// -----------------------------------------------------------------------------
/*
 *  'GW2Event'      --->                            /v1/event_details.json
 *  'GW2EventState' --->                            /v1/events.json
 */
#import "GW2Event.h"
#import "GW2EventState.h"

#pragma mark - Guilds
// -----------------------------------------------------------------------------
//  GW2Guild
// -----------------------------------------------------------------------------
/*
 *  'GW2Guild' --->                                 /v1/guild_details.json
 */
#import "GW2Guild.h"

#pragma mark - Maps
// -----------------------------------------------------------------------------
//  GW2EventLocation
// -----------------------------------------------------------------------------
/*
 *  'GW2EventLocation' --->                         /v1/event_datils.json
 */
#import "GW2EventLocation.h"
// -----------------------------------------------------------------------------
//  GW2MapBasic
// -----------------------------------------------------------------------------
/*
 *  'GW2MapBasic' --->                              /v1/maps.json
 */
#import "GW2MapBasic.h"
// -----------------------------------------------------------------------------
//  GW2MapContinent
// -----------------------------------------------------------------------------
/*
 *  'GW2MapContinent' --->                          /v1/continents.json
 */
#import "GW2MapContinent.h"
// -----------------------------------------------------------------------------
//  GW2MapRegion
// -----------------------------------------------------------------------------
/*
 *  'GW2MapRegion' --->                             /v1/map_floor.json
 */
#import "GW2MapRegion.h"

#pragma mark - WvW
// -----------------------------------------------------------------------------
//  GW2WvW
// -----------------------------------------------------------------------------
/*
 *  'GW2WvWMatch'   --->                            /v1/wvw/matches.json
 *  'GW2WvWMatchUp' --->                            /v1/wvw/match_details.json
 */
#import "GW2WvWMatch.h"
#import "GW2WvWMatchUp.h"

#pragma mark - Misc
// -----------------------------------------------------------------------------
//  GW2Color
// -----------------------------------------------------------------------------
/*
 *  'GW2Color' --->                                 /v1/colors.json
 */
#import "GW2Color.h"