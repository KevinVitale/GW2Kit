//
//  GW2ContinentDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2ContinentDetail : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSArray *continent_dims;
@property (copy, nonatomic) NSNumber *min_zoom;
@property (copy, nonatomic) NSNumber *max_zoom;
@property (copy, nonatomic) NSArray *floors;

+ (RKObjectMapping *)mappingObject;
@end
