//
//  GW2Guild.h
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2Object.h"

@protocol GW2GuildEmblem <GW2Object>
@property       (nonatomic, readonly) NSInteger backgroundID;
@property       (nonatomic, readonly) NSInteger foregroundID;
@property       (nonatomic, readonly) NSInteger backgroundColorID;
@property       (nonatomic, readonly) NSInteger foregroundPrimaryColorID;
@property       (nonatomic, readonly) NSInteger foregroundSecondaryColorID;
@property (copy, nonatomic, readonly) NSArray   *flags;
@end

@protocol GW2Guild <GW2Object>
@property (copy, nonatomic, readonly) NSString *tag;
@property (nonatomic, readonly) id<GW2GuildEmblem> emblem;
@end
