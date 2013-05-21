//
//  GW2WorldDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2WorldDetail : NSObject
@property (copy, nonatomic) NSString *worldID;
@property (copy, nonatomic) NSString *name;

+ (RKObjectMapping *)mappingObject;

@end
