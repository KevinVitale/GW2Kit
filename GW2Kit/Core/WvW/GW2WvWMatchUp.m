//
//  GW2WvWMatchUp.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2WvWMatchUp.h"
#import "GW2Object+Private.h"

@interface _GW2WvWMatchUp : _GW2Object <GW2WvWMatchUp>
@property       (nonatomic, readonly) NSInteger redWorldID;
@property       (nonatomic, readonly) NSInteger blueWorldID;
@property       (nonatomic, readonly) NSInteger greenWorldID;
@property (copy, nonatomic, readonly) NSDate    *startDate;
@property (copy, nonatomic, readonly) NSDate    *endDate;
@end


@implementation _GW2WvWMatchUp
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}
+ (NSValueTransformer *)startDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}
+ (NSValueTransformer *)endDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        propertyID      : @"wvw_match_id",
        @"redWorldID"   : @"red_world_id",
        @"blueWorldID"  : @"blue_world_id",
        @"greenWorldID" : @"green_world_id",
        @"startDate"    : @"start_time",
        @"endDate"      : @"end_time",
        @"name"         : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
