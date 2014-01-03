//
//  GW2Object.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2Object.h"

@interface GW2Object ()
@property (copy, nonatomic, readwrite) id objectID;
@property (copy, nonatomic, readwrite) NSString *name;
@end

@implementation GW2Object
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"objectID" : @"id"};
}
+(instancetype)objectWithID:(id)objectID
                       name:(NSString *)name
         fromJSONDictionary:(NSDictionary *)JSONDictionary
                      error:(NSError *__autoreleasing *)error {
    id object = [MTLJSONAdapter modelOfClass:self.class
                          fromJSONDictionary:JSONDictionary
                                       error:error];
    
    if(![object valueForKey:@"objectID"]) {
        [object setValue:objectID forKey:@"objectID"];
    }
    if(![object valueForKey:@"name"]) {
        [object setValue:name forKey:@"name"];
    }
    return object;
}
@end