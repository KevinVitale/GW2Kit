//
//  GW2WvWMatchDetail
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2WvWMatchDetail : NSObject
@property (copy, nonatomic) NSString *matchID;
@property (copy, nonatomic) NSArray *scores;
@property (copy, nonatomic) NSArray *maps;

+ (RKObjectMapping *)mappingObject;

@end
