//
//  GW2EventDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 6/24/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;


@interface GW2EventLocation : NSObject
@property (copy, nonatomic) NSString    *type;
@property (copy, nonatomic) NSArray     *centerPosition;
@property (copy, nonatomic) NSNumber    *radius;
@property (copy, nonatomic) NSNumber    *rotation;

+ (RKObjectMapping *)mappingObject;
@end



#pragma mark - Event Detail
@interface GW2EventDetail : NSObject

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *level;
@property (copy, nonatomic) NSString *mapID;
@property (copy, nonatomic) NSArray  *flags;
@property (strong, nonatomic) GW2EventLocation *location;

+ (RKObjectMapping *)mappingObject;
@end