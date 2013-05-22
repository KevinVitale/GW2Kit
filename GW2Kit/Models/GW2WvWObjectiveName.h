//
//  GW2WvWObjectiveName.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2WvWObjectiveName : NSObject

@property (copy, nonatomic) NSString *objectiveID;
@property (copy, nonatomic) NSString *name;

+ (RKObjectMapping *)mappingObject;

@end
