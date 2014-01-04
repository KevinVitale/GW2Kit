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
    
    // This is the method we intend to wrap around.
    id object = [MTLJSONAdapter modelOfClass:self.class
                          fromJSONDictionary:JSONDictionary
                                       error:error];
    
    // Check to see if 'objectID' was set via the JSONDictionary
    if(![object valueForKey:@"objectID"]) {
        [object setValue:objectID forKey:@"objectID"];
    }
    // Check to see if 'name' was set via the JSONDictionary
    if(![object valueForKey:@"name"]) {
        [object setValue:name forKey:@"name"];
    }
    
    // Return
    return object;
}
@end