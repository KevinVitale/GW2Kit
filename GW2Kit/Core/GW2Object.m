//
//  GW2Object.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2Object+Private.h"

@interface _GW2Object ()
@property (copy, nonatomic, readwrite) NSString *objectID;
@property (copy, nonatomic, readwrite) NSString *name;
@end

@implementation _GW2Object
- (NSString *)debugDescription {
    return self.JSONRepresentation.debugDescription;
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"objectID" : @"id"};
}
+ (instancetype)objectWithID:(id)objectID
                        name:(NSString *)name
          fromJSONDictionary:(NSDictionary *)JSONDictionary
                       error:(NSError *__autoreleasing *)error {
    
    // This is the method we intend to wrap around.
    return ({
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
        
        // 'gcc' trick; make this is the last thing called
        object;
    });
}

- (NSDictionary *)JSONRepresentation {
    if([self conformsToProtocol:@protocol(MTLJSONSerializing)] &&
       [self isKindOfClass:[MTLModel class]]) {
        return [MTLJSONAdapter JSONDictionaryFromModel:(MTLModel <MTLJSONSerializing> *)self];
    }
    return nil;
}

+ (NSString *)managedObjectEntityName {
    return @"GW2Object";
}
+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return [self.class JSONKeyPathsByPropertyKey];
}
@end