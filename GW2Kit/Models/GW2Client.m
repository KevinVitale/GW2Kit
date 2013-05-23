//
//  GW2Client.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2Client.h"
#import <GW2Kit.h>

#pragma mark - Private Methods
@interface GW2Client ()
@end


#pragma mark -
#pragma mark GW2 Client
@implementation GW2Client

#pragma mark - Initialization
- (id)initWithHTTPClient:(AFHTTPClient *)client {
    self = [super initWithHTTPClient:client];
    if(self) {
        [self addResponseDescriptorsFromArray:@[

         
         // Events: events.json
         [RKResponseDescriptor responseDescriptorWithMapping:[GW2EventStatus mappingObject]
                                                 pathPattern:nil
                                                     keyPath:@"events"
                                                 statusCodes:nil],
         // Resource Name: {resource}_names.json
         [RKResponseDescriptor responseDescriptorWithMapping:[GW2ResourceName mappingObject]
                                                 pathPattern:nil
                                                     keyPath:nil
                                                 statusCodes:nil],
         
         // WvW Matche Details: wvw/matches.json
         [RKResponseDescriptor responseDescriptorWithMapping:[GW2WvWMatch mappingObject]
                                                 pathPattern:nil
                                                     keyPath:@"wvw_matches"
                                                 statusCodes:nil],
         
         // WvW Matche Details: wvw/match_details.json
         [RKResponseDescriptor responseDescriptorWithMapping:[GW2WvWMatchDetail mappingObject]
                                                 pathPattern:@"/v1/wvw/match_details.json"
                                                     keyPath:nil
                                                 statusCodes:nil],

         // Recipe Details: recipe_details.json
         [RKResponseDescriptor responseDescriptorWithMapping:[GW2RecipeDetail mappingObject]
                                                 pathPattern:@"/v1/recipe_details.json"
                                                     keyPath:nil
                                                 statusCodes:nil]
         ]];
        
    }
    return self;
}

#pragma mark - Resource Names
- (void)namesForResource:(NSString *)resource
              parameters:(NSDictionary *)parameters
              completion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *names) {
        if(completion)
            completion(error, names);
    };
    
    [self getObjectsAtPath:[NSString stringWithFormat:@"/v1/%@_names.json", resource]
                parameters:parameters
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
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
    
    RKObjectRequestOperation *weak_op = operation;
    [operation setCompletionBlock:^{
        RKObjectRequestOperation *strong_op = weak_op;
        finalCompletion(strong_op. error, [strong_op.mappingResult.array.lastObject valueForKey:@"items"]);
    }];
    [self enqueueObjectRequestOperation:operation];
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
    

    RKObjectRequestOperation *weak_op = operation;
    [operation setCompletionBlock:^{
        RKObjectRequestOperation *strong_op = weak_op;
        finalCompletion(strong_op. error, strong_op.mappingResult.array.lastObject);
    }];
    [self enqueueObjectRequestOperation:operation];
}

- (void)eventStatesWithParameters:(NSDictionary *)parameters
                       completion:(void (^)(NSError *, NSArray *))completion {
    
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *events) {
        if(completion)
            completion(error, events);
    };
    
    [self getObjectsAtPath:@"/v1/events.json"
                parameters:parameters
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
}

- (void)wvwMatchesWithCompletion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *states) {
        if(completion)
            completion(error, states);
    };
    
    [self getObjectsAtPath:@"/v1/wvw/matches.json"
                parameters:nil
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
}

- (void)wvwMatchDetailForID:(NSString *)matchID
                 completion:(void (^)(NSError *, GW2WvWMatchDetail *))completion {
    void (^finalCompletion)(NSError *, GW2WvWMatchDetail *) = ^ (NSError *error, GW2WvWMatchDetail *matchDetail) {
        if(completion)
            completion(error, matchDetail);
    };
    
    [self getObjectsAtPath:@"/v1/wvw/match_details.json"
                parameters:@{ @"match_id" : matchID }
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array.lastObject);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
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
    
    RKObjectRequestOperation *weak_op = operation;
    [operation setCompletionBlock:^{
        RKObjectRequestOperation *strong_op = weak_op;
        finalCompletion(strong_op. error, [strong_op.mappingResult.array.lastObject valueForKey:@"recipes"]);
    }];
    [self enqueueObjectRequestOperation:operation];
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
    
    [self getObjectsAtPath:@"/v1/recipe_details.json"
                parameters:params
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array.lastObject);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
}

+ (GW2Client *)sharedClient {
    static dispatch_once_t onceToken;
    static GW2Client *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GW2Client alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"https://api.guildwars2.com"]]];
    });
    return instance;
}
@end

@implementation GW2Client (Reactive)
- (RACSignal *)signalOfNamesForResource:(NSString *)resource parameters:(NSDictionary *)parameters {
    RACSubject *subject = [RACSubject subject];
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *names) {
        if(error) {
            [subject sendError:error];
        }
        
        else {
            [subject sendNext:names];
            [subject sendCompleted];
        }
    };
    
    [self getObjectsAtPath:[NSString stringWithFormat:@"/v1/%@_names.json", resource]
                parameters:parameters
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
    return subject;
}
@end
