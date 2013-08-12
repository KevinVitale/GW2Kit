//
//  GW2ItemsDaemon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/21/13.
//
//

#import "GW2ItemsDaemon.h"
#import "GW2ItemDetail.h"
#import "GW2RecipeDetail.h"

@implementation GW2ItemsDaemon

#pragma mark - Initialization
- (id)init {
    self = [super init];
    if(self) {
        [self addResponseDescriptorsFromArray:@[[RKResponseDescriptor responseDescriptorWithMapping:[GW2ItemDetail mappingObject]
                                                                                             method:RKRequestMethodGET
                                                                                        pathPattern:@"/v1/item_details.json"
                                                                                            keyPath:nil
                                                                                        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)],
                                                [RKResponseDescriptor responseDescriptorWithMapping:[GW2RecipeDetail mappingObject]
                                                                                             method:RKRequestMethodGET
                                                                                        pathPattern:@"/v1/recipe_details.json"
                                                                                            keyPath:nil
                                                                                        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]
                                                ]];
    }
    return self;
}

#pragma mark - Fetch Items
- (void)itemsWithCompletion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, id) = ^(NSError *error, id result) {
        if(completion)
            completion(error, result);
    };
    
    RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [itemMapping addAttributeMappingsFromArray:@[@"items"]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.guildwars2.com/v1/items.json"]];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    
    RKObjectRequestOperation *weak_op = operation;
    [operation setCompletionBlock:^{
        RKObjectRequestOperation *strong_op = weak_op;
        finalCompletion(strong_op.error, [strong_op.mappingResult.array.lastObject valueForKey:@"items"]);
    }];
    [self enqueueObjectRequestOperation:operation];
}

- (void)itemDetailForID:(NSString *)itemID
             parameters:(NSDictionary *)parameters
             completion:(void (^)(NSError *, GW2ItemDetail *))completion {
    
    void (^finalCompletion)(NSError *, id) = ^(NSError *error, id result) {
        if(completion)
            completion(error, result);
    };
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:parameters];
    if(itemID)
        params[@"item_id"] = itemID;
    
    // Fetch the event names
    [self getObjectsAtPath:@"/v1/item_details.json"
                parameters:params
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array.lastObject);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       DLog(@"%@", error);
                       finalCompletion(error, nil);
                   }];
}


#pragma mark - Fetch Recipes
- (void)recipesWithCompletion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *states) {
        if(completion)
            completion(error, states);
    };
    
    RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [itemMapping addAttributeMappingsFromArray:@[@"recipes"]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemMapping
                                                                                            method:RKRequestMethodGET
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
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params addEntriesFromDictionary:parameters];
    if(recipeID)
        params[@"recipe_id"] = recipeID;
    
    [self fetchRequestAtPath:@"/v1/recipe_details.json"
                  parameters:params
                  completion:^(NSError *error, id result) {
                      if(completion) {
                          completion(error, [result lastObject]);
                      }
                  }];
}


#pragma mark - App Notifications
- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    
    
    /*
    [self recipeDetailForID:@"1"
                 parameters:nil
                 completion:^(NSError *error, GW2RecipeDetail *recipeDetail) {
                     DLog(@"Recipe detail fetched...");
                     printf("%s\n", recipeDetail.description.UTF8String);
                 }];
    
    static BOOL pullDetails = YES;
    [self itemsWithCompletion:^(NSError *error, NSArray *items) {
        DLog(@"Items fetched...");
        for(int x = 0; x < 5; x++) {
            printf("%s\n", [items[x] description].UTF8String);
            if(pullDetails) {
                pullDetails = NO;
                [self itemDetailForID:items[x]
                           parameters:nil
                           completion:^(NSError *error, GW2ItemDetail *itemDetail) {
                               DLog(@"Item details fetched...");
                               printf("%s\n", itemDetail.description.UTF8String);
                           }];
            }
        }
    }];
     */
}

#pragma mark - Daemon
+ (instancetype)daemon {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}
@end
