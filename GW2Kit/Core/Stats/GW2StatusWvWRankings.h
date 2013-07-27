//
//  GW2StatusWvWRankings.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2StatusWvWRank : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSDictionary *rating;
+ (RKObjectMapping *)mapping;
@end

@interface GW2StatusWvWRankings : NSObject
@property (copy, nonatomic) NSDate *retrievalDate;
@property (copy, nonatomic) NSNumber *count;
@property (copy, nonatomic) NSArray *northAmericanRankings;
@property (copy, nonatomic) NSArray *europeanRankings;

+ (RKObjectMapping *)mapping;
@end
