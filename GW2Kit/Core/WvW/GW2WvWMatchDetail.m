//
//  GW2WvWMatchDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import "GW2WvWMatchDetail.h"
#import <RestKit/RestKit.h>

@implementation GW2WvWMatchDetail
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
             @"match_id" : @"matchID",
             @"scores" : @"scores",
             @"maps" : @"maps"
             };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}
@end
