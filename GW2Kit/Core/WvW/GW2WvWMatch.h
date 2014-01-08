//
//  GW2WvWMatch.h
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import "GW2Object.h"

@protocol GW2WvWMatchObjective <GW2Object>
@property (copy, nonatomic, readonly) NSString *realmOwner;
@property (copy, nonatomic, readonly) NSString *guildID;
@end

@protocol GW2WvWBattlegroundBonus <NSObject>
@property (copy, nonatomic, readonly) NSString *type;
@property (copy, nonatomic, readonly) NSString *realmOwner;
@end

/**
 *  There are four battleground which worlds fight over:
 *    - RedHome
 *    - GreenHome
 *    - BlueHome
 *    - Center
 *
 *  @note In the original API response, these 4 battlegrounds are 'type'. This
 *          object converts 'type' as 'name'.
 *
 *  Each battleground has a set of objectives, and each objective is held
 *  by a realm owner (or is neutral). The possible realm owners are:
 *    - Red
 *    - Green
 *    - Blue
 */
@interface GW2WvWBattleground : GW2Object
@property (copy, nonatomic, readonly) NSArray *scores;
@property (copy, nonatomic, readonly) NSArray *objectives;
@property (copy, nonatomic, readonly) NSArray *bonuses;
@end

/**
 *  WvW match.
 */
@interface GW2WvWMatch : GW2Object
@property (copy, nonatomic, readonly) NSArray *scores;
@property (copy, nonatomic, readonly) NSArray *battlegrounds;
@end