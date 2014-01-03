//
//  GW2EventState.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#import "GW2EventState.h"

@interface GW2EventState ()
@property (copy, nonatomic, readwrite) NSString *state;
@property (nonatomic, readwrite) NSInteger worldID;
@property (nonatomic, readwrite) NSInteger mapID;
@end

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
