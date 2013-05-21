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
    [description insertString:[NSString stringWithFormat:@"\n%@\n[#%@] %@\n%@\n", dashedLineString, self.itemID, self.name, dashedLineString] atIndex:0];
    [description appendString:dashedLineString];
    
    return description;
}

+ (NSDictionary *)mappingAttributes {
    return @{
             @"item_id":        @"itemID",
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
        
        // I don't how many type we'll need to write custom classes for yet...
        // Candidates are 'weapon', 'consumable', 'armor'...
        //
        /*
        if([representation valueForKey:@"weapon"]) {
            [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weapon"
                                                                                    toKeyPath:@"info"
                                                                                  withMapping:[GW2WeaponInfo mappingObject]]];
        }
        
        else if([representation valueForKey:@"consumable"]) {
            [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"consumable"
                                                                                    toKeyPath:@"info"
                                                                                  withMapping:[GW2ConsumableInfo mappingObject]]];
        }
        
        else {
            NSString *expectedType = [[representation valueForKey:@"type"] lowercaseString];
            NSDictionary *typeInfo = [representation valueForKey:expectedType];
            if(typeInfo) {
                [mapping addAttributeMappingsFromDictionary:@{expectedType: @"info"}];
            }
        }
         */
        ////////////////////////////////////////////////////////////////////////////////
        
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

// We'll get back to these custom classes at some point...

/*
@implementation GW2WeaponInfo
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
             @"type":           @"type",
             @"damage_type":    @"damageType",
             @"minPower":       @"minPower",
             @"maxPower":       @"maxPower",
             @"defense":        @"defense",
             @"infusion_slots": @"infusionSlots",
             @"infix_upgrade":  @"infixUpgrade",
             @"suffix_item_id": @"suffixItemID",
             };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}
@end

@implementation GW2ConsumableInfo
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
             @"type": @"type",
             @"duration_ms" : @"duration",
             @"description" : @"detail"
             };
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}
@end
 */