//
//  GW2Client.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/20/13.
//
//

#import "GW2Client.h"
#import "GW2Kit.h"

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
         // Build details: build.json
         [RKResponseDescriptor responseDescriptorWithMapping:[GW2Build mappingObject]
                                                 pathPattern:@"/v1/build.json"
                                                     keyPath:nil
                                                 statusCodes:nil],
         
         // Color details: colors.json
         [RKResponseDescriptor responseDescriptorWithMapping:[GW2Color mappingObject]
                                                 pathPattern:@"/v1/colors.json"
                                                     keyPath:@"colors"
                                                 statusCodes:nil]
         ]];
        
    }
    return self;
}

#pragma mark - IN PROGRESS
- (void)buildWithCompletion:(void (^)(NSError *, GW2Build *))completion {
    void (^finalCompletion)(NSError *, GW2Build *) = ^ (NSError *error, GW2Build *build) {
        if(completion)
            completion(error, build);
    };
    
    [self getObjectsAtPath:@"/v1/build.json"
                parameters:nil
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, mappingResult.array.lastObject);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
}

- (void)colorsWithCompletion:(void (^)(NSError *, NSArray *))completion {
    void (^finalCompletion)(NSError *, NSArray *) = ^ (NSError *error, NSArray *colors) {
        if(completion)
            completion(error, colors);
    };
    
    [self getObjectsAtPath:@"/v1/colors.json"
                parameters:nil
                   success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                       finalCompletion(nil, [mappingResult.array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                           return (([[obj1 id] integerValue] < [[obj2 id] integerValue]) ? NSOrderedAscending : NSOrderedDescending);
                       }]);
                   }
                   failure:^(RKObjectRequestOperation *operation, NSError *error) {
                       finalCompletion(error, nil);
                   }];
}



#pragma mark - Singleton
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
