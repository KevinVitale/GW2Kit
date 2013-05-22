//
//  GW2WvWMatch.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2WvWMatch : NSObject

@property (copy, nonatomic) NSString *matchID;
@property (copy, nonatomic) NSString *redWorldID;
@property (copy, nonatomic) NSString *blueWorldID;
@property (copy, nonatomic) NSString *greenWorldID;

+ (RKObjectMapping *)mappingObject;

@end
