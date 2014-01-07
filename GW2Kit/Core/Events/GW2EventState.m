//
//  GW2EventState.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#import "GW2EventState.h"

@implementation GW2EventState
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"worldID"  : @"world_id",
        @"mapID"    : @"map_id",
        @"objectID" : @"event_id",
        @"name"     : NSNull.null
    };
}
@end
