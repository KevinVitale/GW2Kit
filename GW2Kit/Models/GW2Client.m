//
//  GW2Client.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2Client.h"
#import <GW2Kit.h>

@implementation GW2Client

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if(self) {
        
    }
    return self;
}

- (void)namesForResource:(NSString *)resource
              parameters:(NSDictionary *)parameters
              completion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *states) {
        if(completion)
            completion(error, states);
    };
    
    NSURLRequest *request = [self requestWithMethod:@"GET"
                                               path:[NSString stringWithFormat:@"/v1/%@_names.json", resource]
                                         parameters:parameters];
    
    RKMapping *eventsMapping = [GW2ResourceName mappingObject];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eventsMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation.error, operation.mappingResult.array);
}

- (void)itemsWithCompletion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *states) {
        if(completion)
            completion(error, states);
    };

    RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [itemMapping addAttributeMappingsFromArray:@[@"items"]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.guildwars2.com/v1/items.json"]];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation. error, [operation.mappingResult.array.lastObject valueForKey:@"items"]);
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

- (void)wvwMatchesWithCompletion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *states) {
        if(completion)
            completion(error, states);
    };
    
    NSURLRequest *request = [self requestWithMethod:@"GET"
                                               path:@"/v1/wvw/matches.json"
                                         parameters:nil];
    
    RKMapping *wvwMatchesMapping = [GW2WvWMatch mappingObject];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:wvwMatchesMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:@"wvw_matches"
                                                                                       statusCodes:nil];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation.error, operation.mappingResult.array);
}

- (void)wvwMatchDetailForID:(NSString *)matchID
                 completion:(void (^)(NSError *, GW2WvWMatchDetail *))completion {
    void (^finalCompletion)(NSError *, GW2WvWMatchDetail *) = ^ (NSError *error, GW2WvWMatchDetail *matchDetail) {
        if(completion)
            completion(error, matchDetail);
    };
    
    NSURLRequest *request = [self requestWithMethod:@"GET"
                                               path:@"/v1/wvw/match_details.json"
                                         parameters:@{ @"match_id" : matchID }];
    
    RKMapping *mapping = [GW2WvWMatchDetail mappingObject];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation.error, operation.mappingResult.array.lastObject);
}

- (void)recipesWithCompletion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *states) {
        if(completion)
            completion(error, states);
    };
    
    RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [itemMapping addAttributeMappingsFromArray:@[@"recipes"]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.guildwars2.com/v1/recipes.json"]];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation. error, [operation.mappingResult.array.lastObject valueForKey:@"recipes"]);
}

- (void)recipeDetailForID:(NSString *)recipeID
               parameters:(NSDictionary *)parameters
               completion:(void (^)(NSError *, GW2RecipeDetail *))completion {
    void (^finalCompletion)(NSError *, GW2RecipeDetail *) = ^ (NSError *error, GW2RecipeDetail *recipeDetail) {
        if(completion)
            completion(error, recipeDetail);
    };
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:parameters];
    if(recipeID)
        params[@"recipe_id"] = recipeID;
    
    NSURLRequest *request = [self requestWithMethod:@"GET"
                                               path:@"/v1/recipe_details.json"
                                         parameters:params];
    
    RKMapping *mapping = [GW2RecipeDetail mappingObject];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    
#warning FIX ME: Requests should not be done synchronously
    [operation start];
    [operation waitUntilFinished];
    
    finalCompletion(operation.error, operation.mappingResult.array.lastObject);
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
