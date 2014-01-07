//
//  GW2Guild.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2Guild.h"

@implementation GW2GuildEmblem
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"backgroundID" : @"background_id",
        @"foregroundID" : @"foreground_id",
        @"backgroundColorID" : @"background_color_id",
        @"foregroundPrimaryColorID" : @"foreground_primary_color_id",
        @"foregroundSecondaryColorID" : @"foreground_secondary_color_id"
    };
}
@end
@implementation GW2Guild
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"objectID"   : @"guild_id",
        @"name"     : @"guild_name",
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
+ (NSValueTransformer *)locationJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GW2GuildEmblem.class];
}
@end
