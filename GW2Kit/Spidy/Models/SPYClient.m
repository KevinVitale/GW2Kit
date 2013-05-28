//
//  SPYClient.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/28/13.
//
//

#import "SPYClient.h"
#import "SPYItem.h"

@implementation SPYClient

- (id)initWithHTTPClient:(AFHTTPClient *)client {
    self = [super initWithHTTPClient:client];
    if(self) {
        [self addResponseDescriptor:[SPYItem responseDescriptor]];
        RKRoute *itemDetailRoute = [RKRoute routeWithClass:[SPYItem class]
                                               pathPattern:@"/api/v0.9/json/item/:id"
                                                    method:RKRequestMethodGET];
        [self.router.routeSet addRoute:itemDetailRoute];
    }
    return self;
}
- (void)itemDetailForID:(NSString *)itemID completion:(void (^)(NSError *, SPYItem *))completion {
    void (^finalCompletion)(NSError *, SPYItem *) = ^(NSError *error, SPYItem *itemDetail) {
        if(completion)
            completion(error, itemDetail);
    };
    
    SPYItem *item = [SPYItem item];
    item.id = itemID;
    [self getObject:item
               path:nil
         parameters:nil
            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                finalCompletion(nil, mappingResult.array.lastObject);
            }
            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                finalCompletion(error, nil);
            }];
}
+ (SPYClient *)sharedClient {
    static dispatch_once_t onceToken;
    static SPYClient *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[SPYClient alloc] initWithHTTPClient:[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://www.gw2spidy.com/"]]];
    });
    return instance;
}
@end