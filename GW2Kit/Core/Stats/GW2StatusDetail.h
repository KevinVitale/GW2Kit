//
//  GW2StatusDetail.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@class RKObjectMapping;

@interface GW2StatusCode : NSObject
@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *message; // <- Can't be 'description' //
+ (RKObjectMapping *)mapping;
@end

@interface GW2StatusDetail : NSObject
@property (copy, readonly, nonatomic) NSString *name;
@property (copy, nonatomic) NSURL *url;
@property (copy, nonatomic) NSNumber *ping;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSNumber *retrieve;
@property (copy, nonatomic) NSNumber *records;
@property (copy, nonatomic) NSDate *time;

+ (id)mapping;
@end
