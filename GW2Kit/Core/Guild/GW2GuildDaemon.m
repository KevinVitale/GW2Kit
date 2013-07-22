//
//  GW2GuildDaemon.m
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import "GW2GuildDaemon.h"
#import "GW2GuildDetail.h"

@implementation GW2GuildDaemon
- (id)init {
    self = [super init];
    if(self) {
        [self addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:[GW2GuildDetail mappingObject]
                                                                            pathPattern:@"/v1/guild_details.json"
                                                                                keyPath:nil
                                                                            statusCodes:nil]];
    }
    return self;
}
- (void)guildDetailWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *, id))completion {
    [self fetchRequestAtPath:@"/v1/guild_details.json"
                  parameters:parameters
                  completion:^ (NSError *error, id result) {
                      if(completion) {
                          completion(error, [result lastObject]);
                      }
                  }];
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
