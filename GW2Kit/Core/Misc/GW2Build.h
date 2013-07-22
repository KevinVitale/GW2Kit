//
//  GW2Build.h
//  GW2Kit
//
//  Created by Kevin Vitale on 6/1/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2Build : NSObject
@property (copy, nonatomic) NSString *buildID;

+ (RKObjectMapping *)mappingObject;
@end
