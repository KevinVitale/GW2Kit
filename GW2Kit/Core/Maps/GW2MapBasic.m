//
//  GW2MapBasic.m
//  GW2Kit
//
//  Created by Kevin Vitale on 2/1/14.
//
//

#import "GW2MapBasic.h"
#import "GW2Object+Private.h"
#import "MTLValueTransformer+CoreGraphics.h"

@interface _GW2MapBasic : _GW2Object <GW2MapBasic>
@property (assign, nonatomic) NSInteger     continentID;
@property   (copy, nonatomic) NSString      *continentName;
@property (assign, nonatomic) CGRect        continentRect;
@property (assign, nonatomic) NSInteger     defaultFloor;
@property   (copy, nonatomic) NSArray       *floors;
@property (assign, nonatomic) CGRect        frame;
@property (assign, nonatomic) NSUInteger    maxLevel;
@property (assign, nonatomic) NSUInteger    minLevel;
@property (assign, nonatomic) NSInteger     regionID;
@property   (copy, nonatomic) NSString      *regionName;
@end

@implementation _GW2MapBasic
+ (NSValueTransformer *)continentRectJSONTransformer {
    return MTLReversibleRectTransformer(0);
}
+ (NSValueTransformer *)frameJSONTransformer {
    return MTLReversibleRectTransformer(0);
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"continentRect"     : @"continent_rect",
        @"continentID"       : @"continent_id",
        @"continentName"     : @"continent_name",
        @"defaultFloor"      : @"default_floor",
        @"minLevel"          : @"min_level",
        @"maxLevel"          : @"max_level",
        @"objectID"          : NSNull.null,
        @"name"              : @"map_name",
        @"frame"             : @"map_rect",
        @"regionID"          : @"region_id",
        @"regionName"        : @"region_name"
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end