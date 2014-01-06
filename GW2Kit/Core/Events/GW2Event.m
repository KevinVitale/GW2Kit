//
//  GW2Event.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/4/14.
//
//

#import "GW2Event.h"
#import "GW2EventLocation.h"

@implementation GW2Event
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"mapID"    : @"map_id",
        @"objectID" : NSNull.null
    };
}
+ (NSValueTransformer *)locationJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GW2EventLocation.class];
}
@end
