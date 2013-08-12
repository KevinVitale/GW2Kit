//
//  GW2ItemDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2ItemDetail.h"
#import <RestKit/RestKit.h>

@implementation GW2ItemDetail
- (NSString *)description {
    NSUInteger stringLength = 0;
    NSMutableString *description = [NSMutableString string];
    NSMutableArray *attributes = [NSMutableArray arrayWithArray:[[[self class] mappingAttributes] allValues]];
    [attributes addObject:@"info"];
    for(NSString *attribute in attributes) {
        NSString *string = [NSString stringWithFormat:@"| %@: %@\n", [attribute stringByPaddingToLength:40
                                                                                             withString:@" "
                                                                                        startingAtIndex:0], [self valueForKey:attribute]];
        [description appendString:string];
        stringLength = (stringLength < string.length ? string.length : stringLength);
    }
    
    NSString *dashedLineString = [@"" stringByPaddingToLength:MIN(stringLength, 100)
                                                   withString:@"-"
                                              startingAtIndex:0];
    
    [description insertString:[NSString stringWithFormat:@"\n%@\n[#%@] %@\n%@\n", dashedLineString, self.id, self.name, dashedLineString] atIndex:0];
    [description appendString:dashedLineString];
    
    return description;
}

+ (NSDictionary *)mappingAttributes {
    return @{
             @"item_id":        @"id",
             @"name":           @"name",
             @"description":    @"text",
             @"type":           @"type",
             @"rarity":         @"rarity",
             @"vendor_value":   @"vendorValue",
             @"game_types":     @"gameTypes",
             @"flags":          @"flags",
             @"restrictions":   @"restrictions"
             // Missing 'typeInfo' -> 'info' (dynamically determined)
             };
}

+ (RKMapping *)mappingObject {
    
    RKDynamicMapping *infoMapping = [RKDynamicMapping new];
    [infoMapping setObjectMappingForRepresentationBlock:^RKObjectMapping *(id representation) {
        RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
        [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
        
        NSString *expectedType = [[representation valueForKey:@"type"] lowercaseString];
        NSDictionary *typeInfo = [representation valueForKey:expectedType];
        if(typeInfo) {
            [mapping addAttributeMappingsFromDictionary:@{expectedType: @"info"}];
        }
        
        return mapping;
    }];
    
    
    return infoMapping;
}
@end