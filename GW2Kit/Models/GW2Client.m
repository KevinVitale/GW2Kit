//
//  GW2Client.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2Client.h"
#import "GW2ItemDetail.h"
#import "GW2EventStatus.h"

@implementation GW2Client

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if(self) {
        
    }
    return self;
}

- (void)itemDetailForID:(NSString *)itemID
             completion:(void (^)(NSError *, GW2ItemDetail *))completion {
    
    void (^finalCompletion)(NSError *, GW2ItemDetail *) = ^ (NSError *error, GW2ItemDetail *itemDetail) {
        if(completion)
            completion(error, itemDetail);
    };
    
    RKMapping *itemMapping    = [GW2ItemDetail mappingObject];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[@"https://api.guildwars2.com/v1/item_details.json?item_id=" stringByAppendingString:itemID]]];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation.error, operation.mappingResult.array.lastObject);
}

- (void)eventStatesWithParameters:(NSDictionary *)parameters
                       completion:(void (^)(NSError *, NSArray *))completion {
    
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *states) {
        if(completion)
            completion(error, states);
    };
    
    NSURLRequest *request = [self requestWithMethod:@"GET"
                                               path:@"/v1/events.json"
                                         parameters:parameters];
    
    RKMapping *eventsMapping = [GW2EventStatus mappingObject];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventsMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:@"events"
                                                                                       statusCodes:nil];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation.error, operation.mappingResult.array);
}

+ (GW2Client *)sharedClient {
    static dispatch_once_t onceToken;
    static GW2Client *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GW2Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.guildwars2.com"]];
    });
    return instance;
}
@end
