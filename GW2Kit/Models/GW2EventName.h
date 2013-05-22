//
//  GW2EventName.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2EventName : NSObject
@property (copy, nonatomic) NSString *eventID;
@property (copy, nonatomic) NSString *name;

+ (RKObjectMapping *)mappingObject;
@end
