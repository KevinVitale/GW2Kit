//
//  GW2StatusWvWMatches.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface GW2StatusWvWWorld : NSObject
@property (copy, nonatomic) NSString *color;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSDictionary *objectives;
@property (copy, nonatomic) NSDictionary *rating;
@property (copy, nonatomic) NSNumber *pointsPerTick;
@property (copy, nonatomic) NSNumber *score;
@property (copy, nonatomic) NSString *id;
+ (RKObjectMapping *)mapping;
@end


@interface GW2StatusWvWMatch : NSObject
@property (copy, nonatomic) NSArray *worlds;
@property (copy, nonatomic) NSDate *startDate;
@property (copy, nonatomic) NSDate *endDate;
@property (copy, nonatomic) NSDate *lastUpdated;
@property (copy, nonatomic) NSString *matchID;
@property (copy, nonatomic) NSString *uniqueID;

+ (RKObjectMapping *)mapping;
@end

@interface GW2StatusWvwRegion : NSObject
@property (copy, nonatomic) NSString *prefix;
@property (copy, nonatomic) NSArray *matches;
@property (copy, readonly, nonatomic) NSString *name;
+ (RKObjectMapping *)mapping;
@end

#pragma makr - Status (WvW Matches)
@interface GW2StatusWvWMatches : NSObject
@property (copy, nonatomic) NSArray *regions;
@property (copy, nonatomic) NSDate *retrievalDate;

+ (RKObjectMapping *)mapping;
@end
