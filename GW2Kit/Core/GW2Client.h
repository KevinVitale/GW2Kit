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
//  RestAPI, Protocol
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2RestAPI
 *  @abstract   An interface to define objects as having characterics of a 
 *              client which connects to a RESTful service.
 */
@protocol GW2RestAPI <NSObject>
@required
/**
 *  @property   version
 *  @discussion The version of the API. For example, \"v1\", \"v2", etc.
 */
@property (copy, readonly) NSString *version;
@end

#pragma mark - GW2Client, Protocol
// -----------------------------------------------------------------------------
//  Client, Protocol
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2Client
 *  @dicsussion An interface for any client connecting to the GW2 APIs.
 */
@protocol GW2Client <GW2RestAPI, NSCopying>
@required
/**
 *  @property   preferredLanguage
 *  @discussion The language the client is configured for. 
 *              For example, \"en\", \"es\", \"de\", and \"fr\".
 *
 *  @note Defaults to \"en\".
 */
@property (copy, nonatomic, readonly) NSString *preferredLanguage;
@end


#pragma mark - GW2Client, Events
// -----------------------------------------------------------------------------
//  Events, Protocol
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2ClientEvents
 *  @discussion Defines a related collection of methods classes which
 *              communicate with the GW2 API can adopt, specific to names of 
 *              events, maps, and worlds.
 */
@protocol GW2ClientEvents <NSObject>
/**
 *  Fetches all map names.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Object> instance for each
 *          next, then completes.
 *
 *  @note   The client @p preferredLanguage setting determines the locality
 *          for the map names being fetched.
 */
- (RACSignal *)fetchMapNames;

/**
 *  Fetches all world names.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Object> instance for each
 *          next, then completes.
 *
 *  @note   The client @p preferredLanguage setting determines the locality
 *          for the world names being fetched.
 */
- (RACSignal *)fetchWorldNames;

/**
 *  Fetches all event names.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Object> instance for each
 *          next, then completes.
 *
 *  @note   The client @p preferredLanguage setting determines the locality
 *          for the event names being fetched.
 */
- (RACSignal *)fetchEventNames;

/**
 *  Fetches event details for a specific @p eventID, or all event details,
 *  if @p eventID is omitted.
 *
 *  @param  eventID The ID of the event. If @p nil, then all details for
 *                  every known event is returned as every @em next of
 *                  the signal.
 *
 *  @return A @p RACSignal which sends an @p id<GW2Event> instance for each
 *          next, then completes.
 */
- (RACSignal *)fetchEventDetails:(NSString *)eventID;
@end

#pragma mark - GW2Client, Guilds
// -----------------------------------------------------------------------------
//  Guilds
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2ClientGuilds
 *  @discussion Defines a related collection of methods classes which
 *              communicate with the GW2 API can adopt, specific to guilds.
 */
@protocol GW2ClientGuilds <NSObject>

/**
 *  Fetches guild information for a given ID.
 *
 *  @param  guildID The ID of the guild. Cannot be @p nil.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Guild> instance for its 
 *          single next, then completes.
 */
- (RACSignal *)fetchGuildWithID:(NSString *)guildID;

/**
 *  Fetch guild information by name.
 *
 *  @param  guildName The guild name. Cannot be @p nil.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Guild> instance for its 
 *          single next, then completes.
 */
- (RACSignal *)fetchGuildWithName:(NSString *)guildName;
@end

#pragma mark - GW2Client, Maps
// -----------------------------------------------------------------------------
//  Maps
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2ClientMaps
 *  @discussion Defines a related collection of methods classes which
 *              communicate with the GW2 API can adopt, specific to maps and
 *              map/event information.
 */
@protocol GW2ClientMaps <NSObject>
/**
 *  Fetches all continents.
 *
 *  @return A @p RACSignal which sends a @p id<GW2MapContinent> instance for
 *          each of its next, then completes.
 */
- (RACSignal *)fetchContinents;

/**
 *  Fetches continent information for the given ID.
 *
 *  @param continentID The continent ID.
 *
 *  @return A @p RACSignal which sends a @p id<GW2MapContinent> instance for
 *          its single next, then completes.
 *
 *  @note   @p fetchContinents should be used to determine
 *          what continents are available. However, it is likely that \"1\" is
 *          Tyria, and \"2\" is Heart of the Mists.
 */
- (RACSignal *)fetchContinent:(NSString *)continentID;

/**
 *  Fetches all maps.
 *
 *  @return A @p RACSignal which sends a @p id<GW2MapBasic> instance for each
 *          of its next, then completes.
 */
- (RACSignal *)fetchMaps;

/**
 *  Fetches map information for the given ID.
 *
 *  @param  mapID   The map ID. If @p nil, this call behaves the same as @p
 *                  fetchMaps.
 *
 *  @return A @p RACSignal which sends a @p id<GW2MapBasic> instance for each
 *          of its next, then completes.
 */
- (RACSignal *)fetchMap:(id)mapID;

/**
 *  Fetches map floor information for the given @p floor on the associated
 *  @p continent.
 *
 *  @param floor        The floor ID being queried.
 *  @param continentID  The continent ID which the floor belongs.
 *
 *  @return A @p RACSignal which sends a @p id<GW2MapFloor> instance for each
 O          its next, then completes.
 */
- (RACSignal *)fetchMapFloor:(id)floor inContinent:(id)continentID;
@end

#pragma mark - GW2Client, WvW
// -----------------------------------------------------------------------------
//  WvW
// -----------------------------------------------------------------------------
@protocol GW2ClientWvW <NSObject>
/**
 *  Fetches all WvW match results.
 *
 *  @return A @p RACSignal which sends a @p id<GW2WvWMatchUp> instance for each
 *          of its next, then completes.
 */
- (RACSignal *)fetchWvWMatches;

/**
 *  Fetches details for the given match ID.
 *
 *  @param matchID A match ID, returned by @p fetchWvWMatches.
 *
 *  @return A @p RACSignal which sends a @p id<GW2WvWMatch> instance for its
 *          single next, then completes.
 */
- (RACSignal *)fetchWvWMatchDetails:(id)matchID;

/**
 *  Fetches all WvW objective names.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Object> instance for each of
 *          its next, then completes.
 */
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
/**
 *  Fetches the API build version.
 *
 *  @return A @p RACSignal which sends the JSON response (as a NSDictionary)
 *          as its single next, then completes.
 *
 *  @note   This API is pretty useless.
 */
- (RACSignal *)fetchBuild;

/**
 *  Fetches all dyes in the game.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Color> instance for each of its
 *          next, then completes.
 */
- (RACSignal *)fetchColors;
@end

#pragma mark - GW2Client, Files
// -----------------------------------------------------------------------------
//  Files
// -----------------------------------------------------------------------------
@protocol GW2IconFile;
@protocol GW2ClientFiles <NSObject>
/**
 *  Fetches file IDs for in-game items.
 *
 *  @return A @p RACSignal which sends a @p id<GW2Object,GW2IconFile> instance
 *          for each of its next, then completes.
 *
 *  @note   This endpoint provides icons for various in-game UI elements, such
 *          as renown hearts. To download the actual image, use the @p
 *          fetchImageForIconFile: method.
 */
- (RACSignal *)fetchFiles;

/**
 *  Fetches the image resource for a given @p id<GW2IconFile> instance.
 *
 *  @param  iconFile The file being downloaded.
 *
 *  @return A @p RACSignal which sends a @p UIImage (on iOS) or @p NSImage (OSX)
 *          as its single next, then completes.
 */
- (RACSignal *)fetchImageForIconFile:(id<GW2IconFile>)iconFile;
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
