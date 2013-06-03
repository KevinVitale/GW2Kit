//
//  GW2GuildDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 6/3/13.
//
//

#import <Foundation/Foundation.h>


@class RKObjectMapping;

@interface GW2Emblem : NSObject
@property (copy, nonatomic) NSNumber *backgroundImageID;
@property (copy, nonatomic) NSNumber *foregroundImageID;
@property (copy, nonatomic) NSNumber *backgroundColorID;
@property (copy, nonatomic) NSNumber *foregroundPrimaryColorID;
@property (copy, nonatomic) NSNumber *foregroundSecondaryColorID;
@property (copy, nonatomic) NSArray  *flags;

+ (RKObjectMapping *)mappingObject;
@end

@interface GW2GuildDetail : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *tag;
@property (strong, nonatomic) GW2Emblem *emblem;

+ (RKObjectMapping *)mappingObject;
@end
