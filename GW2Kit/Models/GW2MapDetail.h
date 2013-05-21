//
//  GW2MapDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2MapDetail : NSObject
@property (copy, nonatomic) NSString *mapID;
@property (copy, nonatomic) NSString *name;

+ (RKObjectMapping *)mappingObject;
@end
