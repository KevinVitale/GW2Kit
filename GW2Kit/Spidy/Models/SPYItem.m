//
//  SPYItemDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/28/13.
//
//

#import "SPYItem.h"
#import <RestKit/RestKit.h>

@implementation SPYItem
- (NSString *)description {
    NSUInteger stringLength = 0;
    NSMutableString *description = [NSMutableString string];
    for(NSString *attribute in [[[self class] mappingAttributes] allValues]) {
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
             @"name"                : @"name",
             @"data_id"             : @"id",
             @"rarity"              : @"rarity",
             @"restriction_level"   : @"restrictionLevel",
             @"img"                 : @"imageURLString",
             @"type_id"             : @"typeID",
             @"sub_type_id"         : @"subTypeID",
             @"price_last_changed"  : @"priceLastChangedDate",
             @"max_offer_unit_price": @"maxOfferUnitPrice",
             @"min_sale_unit_price" : @"minSaleUnitPrice",
             @"offer_availability"  : @"demandCount",
             @"gw2db_external_id"   : @"gw2dbExternalID",
             @"sale_availability"   : @"quantityAvailable",
             @"sale_price_change_last_hour"     : @"salePriceChangeWithinLastHour",
             @"offer_price_change_last_hour"    : @"offerPriceChangeWithinLastHour",
             };
}

+ (RKResponseDescriptor *)responseDescriptor {
    return [RKResponseDescriptor responseDescriptorWithMapping:[[self class] mappingObject]
                                                        method:RKRequestMethodGET
                                                   pathPattern:@"api/v0.9/json/item/:id"
                                                       keyPath:@"result"
                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}
+ (RKObjectMapping *)mappingObject {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingsFromDictionary:[[self class] mappingAttributes]];
    return mapping;
}
+ (SPYItem *)item {
    return [[self class] new];
}

@end
