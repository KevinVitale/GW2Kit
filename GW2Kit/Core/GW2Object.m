//
//  GW2Object.m
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import "GW2Object+Private.h"

NSString *const propertyID = @"id";

#pragma mark - GW2 Object, API Response
// -----------------------------------------------------------------------------
//  _GW2Object
// -----------------------------------------------------------------------------
@interface _GW2Object ()
@property (copy, nonatomic, readwrite) NSString *id;
@property (copy, nonatomic, readwrite) NSString *name;
@end

#pragma mark - GW2Object
// -----------------------------------------------------------------------------
//  _GW2Object
// -----------------------------------------------------------------------------
@implementation _GW2Object

// -----------------------------------------------------------------------------
//  description
// -----------------------------------------------------------------------------
- (NSString *)description {
    return [[self.debugDescription stringByReplacingOccurrencesOfString:@"\n"
                                                            withString:@"\r"]
    stringByReplacingOccurrencesOfString:@"\"" withString:@""];
}

// -----------------------------------------------------------------------------
//  debugDescription
// -----------------------------------------------------------------------------
- (NSString *)debugDescription {
    return self.JSONRepresentation.description;
}

// -----------------------------------------------------------------------------
//  JSONKeyPathsByPropertyKey
// -----------------------------------------------------------------------------
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{propertyID : @"id"};
}

// -----------------------------------------------------------------------------
//  objectWithID:name:fromJSONDictionary:error:
// -----------------------------------------------------------------------------
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
        if(![object valueForKey:propertyID]) {
            [object setValue:objectID forKey:propertyID];
        }
        // Check to see if 'name' was set via the JSONDictionary
        if(![object valueForKey:@"name"]) {
            [object setValue:name forKey:@"name"];
        }
        
        // 'gcc' trick; make this is the last thing called
        object;
    });
}

// -----------------------------------------------------------------------------
//  JSONRepresentation
// -----------------------------------------------------------------------------
- (NSDictionary *)JSONRepresentation {
    if([self conformsToProtocol:@protocol(MTLJSONSerializing)] &&
       [self isKindOfClass:[MTLModel class]]) {
        return [MTLJSONAdapter JSONDictionaryFromModel:(MTLModel <MTLJSONSerializing> *)self];
    }
    return nil;
}

// -----------------------------------------------------------------------------
//  managedObjectEntityName
// -----------------------------------------------------------------------------
+ (NSString *)managedObjectEntityName {
    return @"GW2Object";
}

// -----------------------------------------------------------------------------
//  managedObjectKeysByPropertyKey
// -----------------------------------------------------------------------------
+ (NSDictionary *)managedObjectKeysByPropertyKey {
    NSDictionary *keysByProperty = ({
        NSMutableDictionary *dict = [@{} mutableCopy];
        dict[propertyID]    = propertyID;
        dict[@"name"]       = @"name";
        [dict copy];
    });
    return keysByProperty;
}
@end


#pragma mark - GW2 Object, Core Data
// -----------------------------------------------------------------------------
//  GW2Object
// -----------------------------------------------------------------------------
@interface GW2Object : NSManagedObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@end

// -----------------------------------------------------------------------------
//  GW2Object
// -----------------------------------------------------------------------------
@implementation GW2Object
@dynamic id;
@dynamic name;
@end