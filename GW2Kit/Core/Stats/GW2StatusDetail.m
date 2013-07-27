//
//  GW2StatusDetail.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import "GW2StatusDetail.h"

@implementation GW2StatusCode
- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:@"\n"];
    [description appendFormat:@"Code: %@\n", self.code];
    [description appendFormat:@"Description: %@\n", self.message];
    
    return description;
}
+ (RKObjectMapping *)mapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping addAttributeMappingFromKeyOfRepresentationToAttribute:@"code"];
    mapping.forceCollectionMapping = YES;
    [mapping addAttributeMappingsFromDictionary:@{@"(code).description" : @"message"}];
    
    return mapping;
}

@end

@implementation GW2StatusDetail
@dynamic name;
- (NSString *)name {
    return self.url.lastPathComponent;
}
- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:@"\n"];
    [description appendFormat:@"--- %@ ---\n", [self.name capitalizedString]];
    [description appendFormat:@"Current Status: %@\n", self.status];
    [description appendFormat:@"Ping Delay: %@\n", self.ping];
    [description appendFormat:@"Retrieve Time: %@\n", self.retrieve];
    [description appendFormat:@"Element Count: %@\n", self.records];
    [description appendFormat:@"Recent Time: %@\n", self.time];
    
    return description;
}
+ (id)mapping {
    
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    mapping.forceCollectionMapping = YES;

    [mapping addAttributeMappingsFromArray:@[@"url", @"ping", @"status", @"retrieve", @"records", @"time"]];

    return mapping;
}
@end
