//
//  GW2GuildDaemon.h
//  GW2Kit
//
//  Created by Kevin Vitale on 7/22/13.
//
//

#import <Foundation/Foundation.h>
#import "GW2DefaultDaemon.h"

@class GW2GuildDetail;

@interface GW2GuildDaemon : GW2DefaultDaemon
/**
 Returns guild details for a specified guild_id or guild_name.
 */
- (void)guildDetailWithParameters:(NSDictionary *)parameters completion:(void (^)(NSError *error, id guildDetail))completion;
@end
