//
//  GW2WvWMatch.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import "GW2WvWMatch.h"
#import <RestKit/RestKit.h>

@implementation GW2WvWMatch
- (NSString *)description {
    NSUInteger stringLength = 0;
    NSMutableString *description = [NSMutableString stringWithString:@"\n"];
    for(RKPropertyMapping *property in [[[self class] mappingObject] propertyMappings]) {
        NSString *attribute = [property destinationKeyPath];
        NSString *string = [NSString stringWithFormat:@"  %@: %@\n", [attribute stringByPaddingToLength:40
                                                                                             withString:@" "
                                                                                        startingAtIndex:0], [self valueForKey:attribute]];
        [description appendString:string];
        stringLength = (stringLength < string.length ? string.length : stringLength);
    }
    
    return description;
}

+ (NSDictionary *)mappingAttributes {
    return @{
             @"wvw_match_id" : @"matchID",
             @"red_world_id" : @"redWorldID",
             @"blue_world_id" : @"blueWorldID",
             @"green_world_id" : @"greenWorldID"
             };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}
@end
