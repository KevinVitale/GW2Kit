//
//  GW2EventState.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#import "GW2EventState.h"
#import "GW2Object+Private.h"

@interface _GW2EventState : _GW2Object <GW2EventState>
@property (copy, nonatomic, readonly) NSString *state;
@property (nonatomic, readonly) NSInteger mapID;
@property (nonatomic, readonly) NSInteger worldID;
@end

@implementation _GW2EventState
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
