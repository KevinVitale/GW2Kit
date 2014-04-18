//
//  GW2Client.h
//  
//
//  Created by Kevin Vitale on 2/22/14.
//
//

@import Foundation;
@class RACSignal;

#pragma mark - GW2RestAPI Protocol
// -----------------------------------------------------------------------------
//  GW2RestAPI
// -----------------------------------------------------------------------------
/**
 *  @protocol
 *  @abstract An interface to define objects as having characterics of a client
 *            which connects to a RESTful service.
 */
@protocol GW2RestAPI <NSObject>
@required
/**
 *  @property   version
 *  @discussion  The version of the API. For example, \"v1\", \"v2", etc.
 */
@property (copy, readonly) NSString *version;
@end

#pragma mark - GW2Client, Protocol
// -----------------------------------------------------------------------------
//  GW2Client
// -----------------------------------------------------------------------------
/**
 *  @protocol GW2Client
 *  @dicsussion An interface for any client connecting to the GW2 APIs.
 */
@protocol GW2Client <GW2RestAPI, NSCopying>
@required

/**
 *  @property preferredLanguage
 *  @discussion The language the client is configured for. 
 *              For example, \"en\", \"es\", \"de\", and \"fr\".
 *  @note Defaults to \"en\".
 */
@property (copy, nonatomic, readonly) NSString *preferredLanguage;
@end


#pragma mark - GW2Client, Events
// -----------------------------------------------------------------------------
//  Events
// -----------------------------------------------------------------------------
@protocol GW2ClientEvents <NSObject>
- (RACSignal *)fetchEventStates;
- (RACSignal *)fetchEventStateForEventIDs:(NSArray *)eventIDs;
- (RACSignal *)fetchEventStatesForMapIDs:(NSArray *)mapIDs;
- (RACSignal *)fetchEventStatesForWorldIDs:(NSArray *)worldIDs;
- (RACSignal *)fetchEventStatesForWorldID:(NSInteger)worldID eventIDs:(NSArray *)eventIDs;
- (RACSignal *)fetchEventStatesForWorldID:(NSInteger)worldID mapID:(NSInteger)mapID;
- (RACSignal *)fetchEventStatesForWorldID:(NSInteger)worldID mapID:(NSInteger)mapID eventID:(NSArray *)eventIDs;
- (RACSignal *)fetchEventNames;
- (RACSignal *)fetchMapNames;
- (RACSignal *)fetchWorldNames;
- (RACSignal *)fetchEventDetails:(NSString *)eventID;
@end

#pragma mark - GW2Client, Guilds
// -----------------------------------------------------------------------------
//  Guilds
// -----------------------------------------------------------------------------
@protocol GW2ClientGuilds <NSObject>
- (RACSignal *)fetchGuildWithID:(NSString *)guildID;
- (RACSignal *)fetchGuildWithName:(NSString *)guildName;
@end

#pragma mark - GW2Client, Maps
// -----------------------------------------------------------------------------
//  Maps
// -----------------------------------------------------------------------------
@protocol GW2ClientMaps <NSObject>
- (RACSignal *)fetchContinents;
- (RACSignal *)fetchContinent:(NSString *)continentID;
- (RACSignal *)fetchMaps;
- (RACSignal *)fetchMap:(id)mapID;
- (RACSignal *)fetchMapFloor:(id)floor inContinent:(id)continentID;
@end

#pragma mark - GW2Client, WvW
// -----------------------------------------------------------------------------
//  WvW
// -----------------------------------------------------------------------------
@protocol GW2ClientWvW <NSObject>
- (RACSignal *)fetchWvWMatches;
- (RACSignal *)fetchWvWMatchDetails:(id)matchID;
- (RACSignal *)fetchWvWObjectiveNames;
@end

#pragma mark - GW2Client, Items
// -----------------------------------------------------------------------------
//  Items
// -----------------------------------------------------------------------------
@protocol GW2ClientItems <NSObject>
/*
 - (RACSignal *)fetchItems;                                  // THROWS EXCEPTION
 - (RACSignal *)fetchItemDetails:(NSString *)itemID;         // THROWS EXCEPTION
 - (RACSignal *)fetchRecipes;                                // THROWS EXCEPTION
 - (RACSignal *)fetchRecipeDetails:(NSString *)recipeID;     // THROWS EXCEPTION
 */
@end

#pragma mark - GW2Client, Misc
// -----------------------------------------------------------------------------
//  Misc
// -----------------------------------------------------------------------------
@protocol GW2ClientMisc <NSObject>
- (RACSignal *)fetchBuild;
- (RACSignal *)fetchColors;
- (RACSignal *)fetchFiles;
@end

#pragma mark - GW2Client, Files
// -----------------------------------------------------------------------------
//  Files
// -----------------------------------------------------------------------------
@protocol GW2ClientFiles <NSObject>
- (RACSignal *)fetchImageWithSignature:(NSString *)signature
                                fileID:(NSString *)fileID;
@end

#pragma mark - GW2Client, V1
// -----------------------------------------------------------------------------
//  Version 1
// -----------------------------------------------------------------------------
@protocol GW2ClientV1
<GW2Client,         GW2ClientEvents,    GW2ClientFiles,     GW2ClientGuilds,
GW2ClientItems,     GW2ClientMaps,      GW2ClientMisc,      GW2ClientWvW>
@end

#pragma mark -
extern id<GW2ClientV1> GW2ClientV1(NSString *preferredLanguage);
