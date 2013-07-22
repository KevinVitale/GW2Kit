//
//  GW2MapResource.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import "GW2MapResource.h"
#import <RestKit/RestKit.h>

@implementation GW2MapResource
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
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"id"];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    mapping.forceCollectionMapping = YES;
    
    return mapping;
}

+ (NSDictionary *)mappingAttributes {
    
    return @{
             @"(id).map_name" : @"map_name",
             @"(id).min_level" : @"min_level",
             @"(id).max_level" : @"max_level",
             @"(id).default_floor" : @"default_floor",
             @"(id).floors" : @"floors",
             @"(id).region_id" : @"region_id",
             @"(id).region_name" : @"region_name",
             @"(id).continent_id" : @"continent_id",
             @"(id).continent_name" : @"continent_name",
             @"(id).map_rect" : @"map_rect",
             @"(id).continent_rect" : @"continent_rect"
             };
}
@end
