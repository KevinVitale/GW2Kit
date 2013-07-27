//
//  GW2StatusDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/26/13.
//
//

#import <GW2Kit/GW2Kit.h>

#define Stats [GW2StatusDaemon daemon]

#pragma mark -
#pragma mark Status Daemon
@interface GW2StatusDaemon : GW2DefaultDaemon

#pragma mark -
#pragma mark API
- (void)statusesWithCompletion:(void (^)(NSError *error, id result))completion;
- (void)codesWithCompletion:(void (^)(NSError *error, id result))completion;
@end
