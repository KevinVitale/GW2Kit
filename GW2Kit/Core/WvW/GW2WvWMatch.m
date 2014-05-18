//
//  GW2WvWMatch.m
//  GW2Kit
//
//  Created by Kevin Vitale on 5/21/13.
//
//

#import "GW2WvWMatch.h"
#import "GW2Object+Private.h"

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
@interface _GW2WvWBattleground : _GW2Object <GW2WvWBattleground>
@property (copy, nonatomic, readonly) NSArray *scores;
@property (copy, nonatomic, readonly) NSArray *objectives;
@property (copy, nonatomic, readonly) NSArray *bonuses;
@end

/**
 *  WvW match.
 */
@interface _GW2WvWMatch : _GW2Object <GW2WvWMatch>
@property (copy, nonatomic, readonly) NSArray *scores;
@property (copy, nonatomic, readonly) NSArray *battlegrounds;
@end

@interface _GW2WvWMatchObjective : _GW2Object <GW2WvWMatchObjective>
@property (copy, nonatomic, readwrite) NSString *realmOwner;
@property (copy, nonatomic, readwrite) NSString *guildID;
@end
@implementation _GW2WvWMatchObjective
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        @"realmOwner"     : @"owner",
        @"guildID"        : @"owner_guild",
        @"name"           : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end

@interface _GW2WvWBattlegroundBonus : _GW2Object <GW2WvWBattlegroundBonus>
@property (copy, nonatomic, readwrite) NSString *type;
@property (copy, nonatomic, readwrite) NSString *realmOwner;
@end

@implementation _GW2WvWBattlegroundBonus
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"realmOwner" : @"owner",
        @"name"       : NSNull.null,
        propertyID    : NSNull.null,
    };
}
@end


@implementation _GW2WvWBattleground
+ (NSValueTransformer *)bonusesJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *bonusesArray) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:bonusesArray.count];
        
        for(NSDictionary *bonusJSON in bonusesArray) {
            _GW2WvWBattlegroundBonus *bonus = [_GW2WvWBattlegroundBonus objectWithID:nil
                                                                                name:nil
                                                                  fromJSONDictionary:bonusJSON
                                                                               error:nil];
            [mutableArray addObject:bonus];
        }
        return [mutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *bonuses) {
                                                             NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:bonuses.count];
                                                             for(_GW2WvWBattlegroundBonus *bonus in bonuses) {
                                                                 [mutableArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:bonus]];
                                                             }
                                                             return [mutableArray copy];
                                                         }];
}
+ (NSValueTransformer *)objectivesJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *objectivesArray) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:objectivesArray.count];
        
        for(NSDictionary *objectiveJSON in objectivesArray) {
            _GW2WvWMatchObjective *objective = [_GW2WvWMatchObjective objectWithID:nil
                                                                              name:nil
                                                                fromJSONDictionary:objectiveJSON
                                                                             error:nil];
            [mutableArray addObject:objective];
        }
        return [mutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *objectives) {
                                                             NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:objectives.count];
                                                             for(_GW2WvWMatchObjective *objective in objectives) {
                                                                 [mutableArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:objective]];
                                                             }
                                                             return [mutableArray copy];
                                                         }];
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @
    {
        @"name"   : @"type",
    };
}
@end

@implementation _GW2WvWMatch
+ (NSValueTransformer *)battlegroundsJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id (NSArray *battlegroundsArray) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:battlegroundsArray.count];
        
        for(NSDictionary *battlegroundJSON in battlegroundsArray) {
            _GW2WvWBattleground *battleground = [_GW2WvWBattleground objectWithID:nil
                                                                           name:nil
                                                             fromJSONDictionary:battlegroundJSON
                                                                          error:nil];
            [mutableArray addObject:battleground];
        }
        return [mutableArray copy];
    }
                                                         reverseBlock:^id (NSArray *battlegrounds) {
                                                             NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:battlegrounds.count];
                                                             for(_GW2WvWBattleground *battleground in battlegrounds) {
                                                                 [mutableArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:battleground]];
                                                             }
                                                             return [mutableArray copy];
                                                         }];
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *superJSONKeyPaths = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    NSDictionary *JSONKeyPaths = @
    {
        propertyID          : @"match_id",
        @"battlegrounds"    : @"maps",
        @"name"             : NSNull.null
    };
    
    [superJSONKeyPaths addEntriesFromDictionary:JSONKeyPaths];
    return [superJSONKeyPaths copy];
}
@end
