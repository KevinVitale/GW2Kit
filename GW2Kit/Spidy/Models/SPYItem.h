//
//  SPYItemDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/28/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;
@class RKResponseDescriptor;

@interface SPYItem : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSNumber *rarity;
@property (copy, nonatomic) NSNumber *restrictionLevel;
@property (copy, nonatomic) NSString *imageURLString;
@property (copy, nonatomic) NSNumber *typeID;
@property (copy, nonatomic) NSNumber *subTypeID;
@property (copy, nonatomic) NSDate   *priceLastChangedDate;
@property (copy, nonatomic) NSNumber *maxOfferUnitPrice;
@property (copy, nonatomic) NSNumber *minSaleUnitPrice;
@property (copy, nonatomic) NSNumber *demandCount;
@property (copy, nonatomic) NSNumber *quantityAvailable;
@property (copy, nonatomic) NSNumber *gw2dbExternalID;
@property (copy, nonatomic) NSNumber *salePriceChangeWithinLastHour;
@property (copy, nonatomic) NSNumber *offerPriceChangeWithinLastHour;

+ (RKResponseDescriptor *)responseDescriptor;
+ (RKObjectMapping *)mappingObject;
+ (SPYItem *)item;
@end
