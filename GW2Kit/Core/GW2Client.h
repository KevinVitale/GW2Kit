//
//  GW2Client.h
//  
//
//  Created by Kevin Vitale on 2/22/14.
//
//

@import Foundation;
@class RACSignal;


/**
 *  @protocol
 *  @abstract An interface to define objects as having characterics of a client
 *            which connects to a RESTful service.
 */
@protocol GW2RestAPI <NSObject>
@required
/**
 *  @property   version
 *  @disccions  The version of the API. For example, \"v1\", \"v2", etc.
 */
@property (copy, readonly) NSString *version;
@end


/**
 *  @protocol GW2Client
 *  @dicsussion An interface for any client connecting to the GW2 APIs.
 */
@protocol GW2Client <GW2RestAPI>
@required

/**
 *  @property preferredLanguage
 *  @discussion The language the client is configured for. 
 *              For example, \"en\", \"es\", \"de\", and \"fr\".
 *  @note Defaults to \"en\".
 */
@property (copy, nonatomic, readonly) NSString *preferredLanguage;
@end

/**
 *  @class GW2Client
 *  @abstract A concrete class used to communicate with all GW2 APIs.
 */
@interface GW2Client : NSObject <GW2Client>
@end

/**
 *  @class GW2ClientVersion1
 *  @abstract A GW2 API client which is automatically configured for version 1.
 */
@interface GW2ClientVersion1 : GW2Client

/**
 *  Instantiates a new GW2 client configured to use version 1 of the API.
 *
 *  @param languageCode Determines which language the responses are in.
 *
 *  @return A @p GW2Client configured for version 1 of the API.
 */
+ (instancetype)clientWithPreferredLanguage:(NSString *)languageCode;

#pragma mark - Events

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

#pragma mark - Guilds
- (RACSignal *)fetchGuildWithID:(NSString *)guildID;
- (RACSignal *)fetchGuildWithName:(NSString *)guildName;

#pragma mark - Items
- (RACSignal *)fetchItems;
- (RACSignal *)fetchItemDetails:(NSString *)itemID;
- (RACSignal *)fetchRecipes;
- (RACSignal *)fetchRecipeDetails:(NSString *)recipeID;

#pragma mark - Map Information
- (RACSignal *)fetchContinents;
- (RACSignal *)fetchMaps;
- (RACSignal *)fetchMap:(id)mapID;
- (RACSignal *)fetchMapFloor:(id)floor inContinent:(id)continentID;

#pragma mark - WvW
- (RACSignal *)fetchWvWMatches;
- (RACSignal *)fetchWvWMatchDetails:(id)matchID;
- (RACSignal *)fetchWvWObjectiveNames;

#pragma mark - Misc
- (RACSignal *)fetchBuild;
- (RACSignal *)fetchColors;
- (RACSignal *)fetchFiles;

#pragma mark - Services
/* tile service */
- (RACSignal *)fetchImageWithSignature:(NSString *)signature
                                fileID:(NSString *)fileID;
@end

