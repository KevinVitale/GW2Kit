//
//  GW2EventDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2EventStatus : NSObject

@property (copy, nonatomic) NSString *worldID;
@property (copy, nonatomic) NSString *mapID;
@property (copy, nonatomic) NSString *eventID;
@property (copy, nonatomic) NSString *state;

+ (NSDictionary *)mappingAttributes;
+ (RKObjectMapping *)mappingObject;
@end
