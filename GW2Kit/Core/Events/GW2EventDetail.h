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


+ (RKObjectMapping *)mappingObject;
@end




@interface GW2EventDetail : NSObject

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *level;
@property (copy, nonatomic) NSString *mapID;
@property (copy, nonatomic) NSArray  *flags;
@property (strong, nonatomic) GW2EventLocation *location;

+ (RKObjectMapping *)mappingObject;
@end


/* 
- Example response:
{
    "events": {
        "EED8A79F-B374-4AE6-BA6F-B7B98D9D7142": {
            "name": "Defeat the renegade charr.",
            "level": 42,
            "map_id": 20,
            "flags": [],
            "location": {
                "type": "sphere",
                "center": [
                    -9463.6,
                    -40310.2,
                    -785.799
                ],
                "radius": 2500,
                "rotation": 0
            }
        }
    }
}
 */