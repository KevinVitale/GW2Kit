//
//  GW2EventDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 6/24/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;


@interface GW2EventLocation : NSObject
@property (copy, nonatomic) NSString    *type;
@property (copy, nonatomic) NSArray     *centerPosition;
@property (copy, nonatomic) NSNumber    *radius;
@property (copy, nonatomic) NSNumber    *rotation;
@property (copy, nonatomic) NSArray     *z_range;
@property (copy, nonatomic) NSArray     *points;

+ (RKObjectMapping *)mappingObject;
@end



#pragma mark - Event Detail
@interface GW2EventDetail : NSObject

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *level;
@property (copy, nonatomic) NSNumber *mapID;
@property (copy, nonatomic) NSArray  *flags;
@property (strong, nonatomic) GW2EventLocation *location;

+ (RKObjectMapping *)mappingObject;
@end

/*!
 /v1/event_details.json
 HTTP method GET Format json API version version 1
 
 This resource returns static details about available events.
 
 Parameters:
 Optional parameters
 event_id – Only list this event.
 lang – Show localized texts in the specified language.

 Response:
 The response is an object with the single property events which contains an object where event ids are mapped to an event details object, containing the following properties:
 
 name (string)       – The name of the event.
 level (int)         – The event level.
 map_id (int)        – The map where the event takes place.
 flags (list)        – A list of additional flags. Possible flags are:
 "group_event"       – For group events
 "map_wide"          – For map-wide events, currently only Defeat the Karka Queen threatening the settlements.
 location (object)   – The location of the event.
 type (string)       – The type of the event location, can be sphere, cylinder or poly.

 Example:
 https://api.guildwars2.com/v1/event_details.json

    {
      "events": {
        "EED8A79F-B374-4AE6-BA6F-B7B98D9D7142": {
          "name": "Defeat the renegade charr.",
          "level": 42,
          "map_id": 20,
          "flags": [],
          "location": {
            "type": "sphere",
            "center": [ -9463.6, -40310.2, -785.799 ],
            "radius": 2500,
            "rotation": 0
          }
        },
        "3A2B85C5-DE73-4402-BD84-8F53AA394A52": {
          "name": "Bonus Event: Cull the Flame Legion",
          "level": 80,
          "map_id": 929,
          "flags": [ "group_event" ],
          "location": {
            "type": "cylinder",
            "center": [ -38.7202, -176.915, -892.494 ],
            "height": 2027.5,
            "radius": 10314.4,
            "rotation": 0
          }
        },
        "CEA84FBF-2368-467C-92EA-7FA60D527C7B": {
          "name": "Find a way to open the door and escape the armory.",
          "level": 8,
          "map_id": 19,
          "flags": [ "group_event" ],
          "location": {
            "type": "poly",
            "center": [ -45685.2, -13819.6, -1113 ],
            "z_range": [ -2389, 163 ],
            "points": [
              [ -49395.8, -15845.5 ],
              [ -42699.7, -15794.1 ],
              [ -43053, -14081.4 ],
              [ -43629.7, -11725.4 ],
              [ -49647.8, -11651.7 ]
            ]
          }
        },
        ...
      }
    }
 */