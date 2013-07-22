//
//  GW2ResourceName.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/22/13.
//
//

#import <Foundation/Foundation.h>


@class RKObjectMapping;

@interface GW2ResourceName : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;

+ (RKObjectMapping *)mappingObject;
@end