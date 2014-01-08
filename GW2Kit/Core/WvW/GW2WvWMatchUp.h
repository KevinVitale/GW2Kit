//
//  GW2WvWMatchUp.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2Object.h"

@interface GW2WvWMatchUp : GW2Object
@property       (nonatomic, readonly) NSInteger redWorldID;
@property       (nonatomic, readonly) NSInteger blueWorldID;
@property       (nonatomic, readonly) NSInteger greenWorldID;
@property (copy, nonatomic, readonly) NSDate    *startDate;
@property (copy, nonatomic, readonly) NSDate    *endDate;
@end
