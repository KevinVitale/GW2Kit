//
//  GW2Item+Private.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/9/14.
//
//

#import "GW2Item.h"
#import "GW2Object+Private.h"

@interface _GW2Item : _GW2Object <GW2Item>
@property (copy, nonatomic, readonly) NSString  *description;
@property (copy, nonatomic, readonly) NSString  *type;
@property (copy, nonatomic, readonly) NSString  *rarity;
@property (copy, nonatomic, readonly) NSArray   *gameTypes;
@property (copy, nonatomic, readonly) NSArray   *flags;
@property (copy, nonatomic, readonly) NSArray   *restrictions;
@property (copy, nonatomic, readonly) NSString  *iconFileSignature;
@property       (nonatomic, readonly) NSInteger iconFileID;
@property       (nonatomic, readonly) NSInteger level;
@property       (nonatomic, readonly) NSInteger vendorValue;
@property       (nonatomic, readwrite) id<GW2ItemType> itemType;
@end
