//
//  GW2Event.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2Event.h"
#import "GW2EventLocation.h"
#import "GW2Object+Private.h"

@interface _GW2Event : _GW2Object <GW2Event>
@property (assign, nonatomic)            NSInteger level;
@property (assign, nonatomic)            NSInteger mapID;
@property (copy,   nonatomic)              NSArray *flags;
@property (strong, nonatomic) id<GW2EventLocation> location;
@end


@implementation _GW2Event
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"mapID"    : @"map_id",
        @"objectID" : NSNull.null
    };
}
+ (NSValueTransformer *)locationJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:NSClassFromString(@"_GW2EventLocation")];
}
@end
