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

#pragma mark - Event Location
/**
 *  GW2EventLocation describes the map location of an event, returned as part
 *  of the 'event_details.json' response.
 *
     "location": {
        "type": "poly",
        "center": [
            -45685.2,
            -13819.6,
            -1113
        ],
        "z_range": [-2389, 163],
        "points": [
            [-49395.8,  -15845.5],
            [-42699.7,  -15794.1],
            [-43053,    -14081.4],
            [-43629.7,  -11725.4],
            [-49647.8,  -11651.7]
        ]
    }
 */
// -----------------------------------------------------------------------------
//  GW2EventLocation
// -----------------------------------------------------------------------------
@protocol GW2EventLocation <GW2Object>
/**
 *  @property   type
 *  Each event has a location. This location defines a geometric volume of 3D game
 *  space, in which the event takes place in the game. In simpler terms, an event 
 *  occurs inside a boundary that has three axises: x, y, and z.
 *
 *  In all cases, the z-axis information (i.e., height, zRange, center.z) can be
 *  ignored, since it's only useful ArenaNet developers working on the game.
 
 *  (My guess is that the event information returned by the 'event_details' API
 *  is (in part) the exact same information used by the Guild Wars 2 engine.)
 *
 *  The type of the event location. Can be:
 *    - sphere
 *    - cylinder
 *    - poly
 */
@property (copy, nonatomic, readonly) NSString *type;

/**
 *  The center-component of the location's volume.
 *
 *  Applicable types:
 *    - sphere
 *    - cylinder
 *    - poly
 */
@property (copy, nonatomic, readonly) NSArray *center;

/**
 *  The depth-component of a "poly" type.
 *
 *  Applicable types:
 *    - poly
 */
@property       (nonatomic, readonly) CGSize zRange;

/**
 *  The vertices (corners) of a "poly" type.
 *
 *  Applicable types:
 *    - poly
 */
@property (copy, nonatomic, readonly) NSArray *points;

/**
 *  The height-component of a "cylinder" type.
 *
 *  Applicable types:
 *    - cylinder
 */
@property       (nonatomic, readonly) CGFloat height;

/**
 *  The radius-component of a "sphere" type.
 *
 *  Applicable types:
 *    - sphere
 *    - cylinder
 */
@property       (nonatomic, readonly) CGFloat radius;

/**
 *  The degree of rotation applied to the boundary of the event.
 *
 *  Applicable types:
 *    - sphere
 *    - cylinder
 */
@property       (nonatomic, readonly) CGFloat rotation;
@end
