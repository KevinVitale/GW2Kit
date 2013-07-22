//
//  GW2EventDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2EventStatus.h"
#import <RestKit/RestKit.h>

@implementation GW2EventStatus
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
             @"world_id":   @"worldID",
             @"map_id":     @"mapID",
             @"event_id":   @"eventID",
             @"state":      @"state"
             };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}

@end