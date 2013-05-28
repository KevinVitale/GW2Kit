//
//  SPYClient.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/28/13.
//
//

#import <RestKit/RestKit.h>

#define Spidy [SPYClient sharedClient]

@class SPYItem;

#pragma mark - Spidy Client
@interface SPYClient : RKObjectManager
- (void)itemDetailForID:(NSString *)itemID
             completion:(void (^)(NSError *error, SPYItem *itemDetail))completion;
+ (SPYClient *)sharedClient;
@end
