//
//  GW2Guild.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2Guild.h"
#import "GW2Object+Private.h"

@interface GW2GuildEmblem : _GW2Object <GW2GuildEmblem>
@property       (nonatomic, readonly) NSInteger backgroundID;
@property       (nonatomic, readonly) NSInteger foregroundID;
@property       (nonatomic, readonly) NSInteger backgroundColorID;
@property       (nonatomic, readonly) NSInteger foregroundPrimaryColorID;
@property       (nonatomic, readonly) NSInteger foregroundSecondaryColorID;
@property (copy, nonatomic, readonly) NSArray   *flags;
@end

@interface GW2Guild : _GW2Object
@property (copy, nonatomic, readonly) NSString *tag;
@property (nonatomic, readonly) GW2GuildEmblem *emblem;
@end


@implementation GW2GuildEmblem
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"backgroundID" : @"background_id",
        @"foregroundID" : @"foreground_id",
        @"backgroundColorID" : @"background_color_id",
        @"foregroundPrimaryColorID" : @"foreground_primary_color_id",
        @"foregroundSecondaryColorID" : @"foreground_secondary_color_id",
        @"objectID" : NSNull.null,
        @"name" : NSNull.null,
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
+ (NSValueTransformer *)emblemJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:GW2GuildEmblem.class];
}
@end
