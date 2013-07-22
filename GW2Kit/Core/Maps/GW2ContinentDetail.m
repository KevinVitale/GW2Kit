//
//  GW2ContinentDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import "GW2ContinentDetail.h"
#import <RestKit/RestKit.h>

@implementation GW2ContinentDetail
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

+ (RKObjectMapping *)mappingObject {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class] ];
    
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"id"];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    mapping.forceCollectionMapping = YES;
    
    return mapping;
}

+ (NSDictionary *)mappingAttributes {
    
    return @{
             @"(id).name" : @"name",
             @"(id).continent_dims" : @"continent_dims",
             @"(id).min_zoom" : @"min_zoom",
             @"(id).max_zoom" : @"max_zoom",
             @"(id).floors" : @"floors",
             };
}
@end
