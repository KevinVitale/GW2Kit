//
//  GW2Client.m
//
//
//  Created by Kevin Vitale on 2/22/14.
//
//

#import "GW2Client.h"
#import "GW2Object.h"
#import "GW2Object+Private.h"
#import "GW2IconFile.h"
#import "CMDQueryStringSerialization.h"
#import <ReactiveCocoa.h>
#import <RACEXTScope.h>


#pragma mark - _GW2Client
// -----------------------------------------------------------------------------
//  GW2Client, Private Class
// -----------------------------------------------------------------------------
/**
 *  @class      GW2Client
 *  @abstract   A concrete class used to communicate with all GW2 APIs.
 */
@interface _GW2Client : NSObject <GW2Client>
// -----------------------------------------------------------------------------
//  Properties
// -----------------------------------------------------------------------------
/**
 *  @property version
 *  @discussion The version of the API the client should use.
 */
@property (copy, nonatomic, readwrite) NSString *version;

/**
 *  @property preferredLanguage
 *  @discussion The language code which will be used during requests.
 */
@property (copy, nonatomic, readwrite) NSString *preferredLanguage;

/**
 *  @property hostname
 *  @discussion The hostname the client connects to.
 *  @note This should be hardcoded to @p api.guildwars2.com.
 */
@property (copy, nonatomic, readwrite) NSString *hostname;

// -----------------------------------------------------------------------------
//  clientWithVersion:preferredLanguage:
// -----------------------------------------------------------------------------
/**
 *  Creates a new client capable of communicating with the GW2 APIs.
 *
 *  @param version      The specific version desired.
 *  @param languageCode Determines which language the responses are in.
 *
 *  @return A @p GW2Client tha can make requests to the GW2 API.
 */
+ (instancetype)clientWithVersion:(NSString *)version
                preferredLanguage:(NSString *)languageCode;

// -----------------------------------------------------------------------------
//  requestPath:parameters:method
// -----------------------------------------------------------------------------
/**
 *  Creates a signal which performs an HTTP request, and sends
 *  the results of the network request at the given path, with
 *  the provided parameters and method.
 *
 *  @param path       The resource at the path to be fetched.
 *  @param parameters Any parameters, required and/or optional, accepted by the resource.
 *  @param method     The HTTP method. Valid methods are: @p GET.
 *
 *  @return A signal that performs the request, sends the results, then completes.
 */
- (RACSignal *)requestPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                    method:(NSString *)method;
@end

#pragma mark - _GW2Client
// -----------------------------------------------------------------------------
//  _GW2Client
// -----------------------------------------------------------------------------
@implementation _GW2Client

#pragma mark - Initialization
// -----------------------------------------------------------------------------
//  init
// -----------------------------------------------------------------------------
- (instancetype)init {
    self = super.init;
    if(self) {
        self.preferredLanguage = @"en";
    }
    return self;
}

// -----------------------------------------------------------------------------
//  initWithVersion:preferredLanguage:
// -----------------------------------------------------------------------------
- (instancetype)initWithVersion:(NSString *)version
              preferredLanguage:(NSString *)preferredLanguage {
    self = self.init;
    if(self) {
        self.version = version;
        self.preferredLanguage = ({
            (preferredLanguage ? : @"en");
        });
    }
    return self;
}

// -----------------------------------------------------------------------------
//  clientWithVersion:preferredLanguage:
// -----------------------------------------------------------------------------
+ (instancetype)clientWithVersion:(NSString *)version
                preferredLanguage:(NSString *)languageCode {
    // Ensure arguments are valid
    NSAssert(version, @"\"version\" can not be 'nil'\n%s", __PRETTY_FUNCTION__);
    
    // Create our client
    id<GW2Client>client = [[self.class alloc] initWithVersion:version
                                            preferredLanguage:languageCode];
    ((_GW2Client *)client).hostname = ({
        [NSString stringWithFormat:@"api.guildwars2.com/%@", version];
    });
    return (id)client;
}

#pragma mark - Copying
// -----------------------------------------------------------------------------
//  copyWithZone:
// -----------------------------------------------------------------------------
- (id<GW2Client>)copyWithZone:(NSZone *)zone {
    id<GW2Client> client = [[self.class allocWithZone:zone] initWithVersion:self.version
                                                          preferredLanguage:self.preferredLanguage];
    ((_GW2Client *)client).hostname = self.hostname;
    
    return client;
}


#pragma mark - Requests
// -----------------------------------------------------------------------------
//  requestWithMethod:path:parameters:
// -----------------------------------------------------------------------------
- (NSURLRequest *)requestWithMethod:(NSString *)method
                               path:(NSString *)path
                         parameters:(NSDictionary *)parameters {
    path = ({
        // If 'path' doesn't end in 'json', make it so!
        ([path.lastPathComponent isEqualToString:@"json"] ?
         path : [path stringByAppendingPathExtension:@"json"]);
    });
    
    NSMutableURLRequest *request = ({
        [[NSURLRequest requestWithURL:
          [NSURL URLWithString:path
                 relativeToURL:
           [NSURL URLWithString:
            [@"https://" stringByAppendingString:
             [self.hostname stringByAppendingPathComponent:self.version]]]
           ]]
         mutableCopy];
    });
    
    NSAssert([request.URL.scheme isEqualToString:@"https"],
             @"\"https\" not found in request URL: '%@'\n%s",
             request.URL.absoluteString,
             __PRETTY_FUNCTION__);
    NSAssert([request.URL.host isEqualToString:@"api.guildwars2.com"],
             @"\"api.guildwars2.com\" not found in request URL: '%@'\n%s",
             request.URL.absoluteString,
             __PRETTY_FUNCTION__);
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setHTTPMethod:method];
    [request setTimeoutInterval:10.f];
    
    
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    
    parameters = ({
        NSMutableDictionary *dict = (parameters.count ? [parameters mutableCopy] : NSMutableDictionary.new);
        dict[@"lang"]             = self.preferredLanguage;
        [dict copy];
    });
    
    if([request.HTTPMethod isEqualToString:@"GET"]) {
        NSString *URLQueryString            = [CMDQueryStringSerialization queryStringWithDictionary:parameters];
        NSString *URLString                 = [request.URL.absoluteString stringByAppendingString:@"?"];
        NSString *URLStringWithQueryParams  = [URLString stringByAppendingString:URLQueryString];
        
        request.URL = [NSURL URLWithString:URLStringWithQueryParams];
    }
    return [request copy];
}

// -----------------------------------------------------------------------------
//  requestPath:parameters:method:
// -----------------------------------------------------------------------------
- (RACSignal *)requestPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                    method:(NSString *)method {
    return
    [RACSignal createSignal:
     ^RACDisposable *(id<RACSubscriber> subscriber) {
         NSOperationQueue *queue = [[NSOperationQueue alloc] init];
         queue.name = @"com.gw2kit.client.request";
         
         // Create our request
         NSURLRequest *request = [self requestWithMethod:method
                                                    path:path
                                              parameters:parameters];
         
         // Send our request
         [NSURLConnection sendAsynchronousRequest:request
                                            queue:queue
                                completionHandler:
          // Connection callback
          ^(NSURLResponse *response, NSData *data, NSError *error) {
              
              // No data means error!
              if (data == nil) {
                  [subscriber sendError:error];
              }
              else {
                  
                  // Convert 'data' to JSON
                  id json =
                  [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingMutableContainers
                                                    error:&error];
                  
                  
                  // Check for errors (both parsing JSON, or service response)
                  if(error ||
                     ({
                      if([json respondsToSelector:@selector(objectForKeyedSubscript:)]) {
                          error = json[@"error"];
                      }
                      error;
                  })) {
                      
                      // If the response was, itself, an error, convert it.
                      if(json[@"error"]) {
                          error = [NSError errorWithDomain:@"GW2APIErrorDomain"
                                                      code:[json[@"error"] integerValue]
                                                  userInfo:({
                              
                              // 'json' will become the error's 'userInfo'
                              json = [NSMutableDictionary dictionaryWithDictionary:json];
                              json[NSURLErrorFailingURLStringErrorKey]  = request.URL.absoluteString;
                              json[NSURLErrorFailingURLErrorKey]        = request.URL;
                              json[@"HTTPMethod"]                       = request.HTTPMethod;
                              [json copy];
                          })];
                      }
                      
                      // Terminate with an error
                      [subscriber sendError:error];
                  }
                  
                  [subscriber sendNext:json];
                  [subscriber sendCompleted];
              }
          }];
         
         return [RACDisposable disposableWithBlock:^{
             // It's not clear if this will actually cancel the connection,
             // but we can at least prevent _some_ unnecessary work --
             // without writing all the code for a proper delegate, which
             // doesn't really belong in RAC.
             queue.suspended = YES;
             [queue cancelAllOperations];
         }];
     }];
}
@end

#pragma mark - GW2Client, Version 1
// -----------------------------------------------------------------------------
//  Version 1
// -----------------------------------------------------------------------------
/**
 *  @class GW2ClientVersion1
 *  @abstract A GW2 API client which is automatically configured for version 1.
 */
@interface      GW2ClientVersion1 : _GW2Client @end
@implementation GW2ClientVersion1
// -----------------------------------------------------------------------------
//  clientWithPreferredLanguage:
// -----------------------------------------------------------------------------
+ (instancetype)clientWithPreferredLanguage:(NSString *)languageCode {
    return [self clientWithVersion:@"v1"
                 preferredLanguage:languageCode];
}

#pragma mark - Events
// -----------------------------------------------------------------------------
//  fetchMapNames
// -----------------------------------------------------------------------------
- (RACSignal *)fetchMapNames {
    return
    [[self requestPath:@"map_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(NSArray *names) {
         return
         [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:namesJSON[@"id"]
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
          signal];
     }];
}

// -----------------------------------------------------------------------------
//  fetchWorldNames
// -----------------------------------------------------------------------------
- (RACSignal *)fetchWorldNames {
    return
    [[self requestPath:@"world_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(NSArray *names) {
         return
         [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:namesJSON[@"id"]
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
          signal];
     }];
}

// -----------------------------------------------------------------------------
//  fetchEventNames
// -----------------------------------------------------------------------------
- (RACSignal *)fetchEventNames {
    return
    [[self requestPath:@"event_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(NSArray *names) {
         return
         [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:namesJSON[@"id"]
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
          signal];
     }];
}

// -----------------------------------------------------------------------------
//  fetchEventDetails:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchEventDetails:(NSString *)eventID {
    
    // Construct the parameter payload, if necessary.
    NSDictionary *parameters;
    (eventID ? ({ parameters = @{@"event_id" : eventID}; }) : nil);
    
    return
    [[self requestPath:@"event_details"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *response) {
         
         // Pull out the array from response.
         NSArray *events = response[@"events"];
         return
         [[events.rac_sequence map:^id(RACTuple *event) {
             return
             [NSClassFromString(@"_GW2Event") objectWithID:event[0]
                                                      name:nil
                                        fromJSONDictionary:event[1]
                                                     error:nil];
         }]
          signal];
     }];
}

#pragma mark - Guilds
// -----------------------------------------------------------------------------
//  fetchGuildWithID:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchGuildWithID:(NSString *)guildID {
    NSDictionary *parameters;
    (guildID ? ({ parameters = @{@"guild_id" : guildID}; }) : nil);
    return
    [[self requestPath:@"guild_details"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *guildJSON) {
         return
         [RACSignal return:
          [NSClassFromString(@"_GW2Guild") objectWithID:nil
                                                   name:nil
                                     fromJSONDictionary:guildJSON
                                                  error:nil]];
     }];

}

// -----------------------------------------------------------------------------
//  fetchGuildWithName:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchGuildWithName:(NSString *)guildName {
    NSDictionary *parameters;
    (guildName ? ({ parameters = @{@"guild_name" : guildName}; }) : nil);
    return
    [[self requestPath:@"guild_details"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *guildJSON) {
         return
         [RACSignal return:
          [NSClassFromString(@"_GW2Guild") objectWithID:nil
                                                   name:nil
                                     fromJSONDictionary:guildJSON
                                                  error:nil]];
     }];
}

/*
 #pragma mark - Items
 - (RACSignal *)fetchItems;
 - (RACSignal *)fetchItemDetails:(NSString *)itemID;
 - (RACSignal *)fetchRecipes;
 - (RACSignal *)fetchRecipeDetails:(NSString *)recipeID;
 */

#pragma mark - Map Information
// -----------------------------------------------------------------------------
//  fetchContinents
// -----------------------------------------------------------------------------
- (RACSignal *)fetchContinents {
    return
    [[self requestPath:@"continents"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *response) {
         NSDictionary *continents = response[@"continents"];
         return
         [[continents.rac_sequence map:^id(RACTuple *continent) {
             return
             [NSClassFromString(@"_GW2MapContinent") objectWithID:continent[0]
                                                             name:nil
                                               fromJSONDictionary:continent[1]
                                                            error:nil];
         }]
          signal];
     }];
}

// -----------------------------------------------------------------------------
//  fetchContinent:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchContinent:(NSString *)continentID {
    return
    [[self fetchContinents]
     filter:^BOOL(id<GW2Object> value) {
         return [[(NSObject *)value valueForKey:propertyID] isEqualToString:continentID];
     }];
}

// -----------------------------------------------------------------------------
//  fetchMaps
// -----------------------------------------------------------------------------
- (RACSignal *)fetchMaps {
    return [self fetchMap:nil];
}

// -----------------------------------------------------------------------------
//  fetchMap:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchMap:(id)mapID {
    NSDictionary *parameters;
    (mapID ? ({ parameters = @{@"map_id" : mapID}; }) : nil);
    return
    [[self requestPath:@"maps"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *response) {
         NSDictionary *maps = response[@"maps"];
         return
         [[maps.rac_sequence map:^id(RACTuple *map) {
             return
             [NSClassFromString(@"_GW2MapBasic") objectWithID:map[0]
                                                         name:nil
                                           fromJSONDictionary:map[1]
                                                        error:nil];
         }]
          signal];
     }];
}

// -----------------------------------------------------------------------------
//  fetchMapFloor:inContinent:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchMapFloor:(id)floor inContinent:(id)continentID {
    
    NSAssert(floor,         @"\"floor\" cannot be 'nil'\n%s", __PRETTY_FUNCTION__);
    NSAssert(continentID,   @"\"continentID\" cannot be 'nil'", __PRETTY_FUNCTION__);
    
    return
    [[self requestPath:@"map_floor"
            parameters:@{@"floor"           : floor,
                         @"continent_id"    : continentID
                         }
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *mapFloorJSON) {
         return
         [RACSignal return:
          [NSClassFromString(@"_GW2MapFloor") objectWithID:nil
                                                      name:nil
                                        fromJSONDictionary:mapFloorJSON
                                                     error:nil]
          ];
     }];
}

#pragma mark - WvW
// -----------------------------------------------------------------------------
//  fetchWvWMatches
// -----------------------------------------------------------------------------
- (RACSignal *)fetchWvWMatches {
    return
    [[self requestPath:@"wvw/matches"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *response) {
         NSArray *matches = response[@"wvw_matches"];
         return
         [[matches.rac_sequence map:^id(NSDictionary *match) {
             return
             [NSClassFromString(@"_GW2WvWMatchUp") objectWithID:nil
                                                           name:nil
                                             fromJSONDictionary:match
                                                          error:nil];
         }]
          signal];
     }];
}

// -----------------------------------------------------------------------------
//  fetchWvWMatchDetails:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchWvWMatchDetails:(id)matchID {
    NSAssert(matchID, @"\"matchID\" cannot be 'nil'\n%s", __PRETTY_FUNCTION__);
    
    return
    [[self requestPath:@"wvw/match_details"
            parameters:@{@"match_id" : matchID}
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *matchJSON) {
         return
         [RACSignal return:
          [NSClassFromString(@"_GW2WvWMatch") objectWithID:matchJSON[@"match_id"]
                                                      name:nil
                                        fromJSONDictionary:matchJSON
                                                     error:nil]
          ];
     }];
}

// -----------------------------------------------------------------------------
//  fetchWvWObjectiveNames
// -----------------------------------------------------------------------------
- (RACSignal *)fetchWvWObjectiveNames {
    return
    [[self requestPath:@"wvw/objective_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(NSArray *names) {
         return
         [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:nil
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
          signal];
     }];
}

#pragma mark - Misc
// -----------------------------------------------------------------------------
//  fetchBuild
// -----------------------------------------------------------------------------
- (RACSignal *)fetchBuild {
    return [self requestPath:@"build"
                  parameters:nil
                      method:@"GET"];
}

// -----------------------------------------------------------------------------
//  fetchColors
// -----------------------------------------------------------------------------
- (RACSignal *)fetchColors {
    return
    [[self requestPath:@"colors"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(NSDictionary *response) {
         NSDictionary *colors = response[@"colors"];
         return
         [[colors.rac_sequence map:^id(RACTuple *color) {
             return
             [NSClassFromString(@"_GW2Color") objectWithID:color[0]
                                                      name:nil
                                        fromJSONDictionary:color[1]
                                                     error:nil];
         }]
          signal];
     }];
}

#pragma mark - Files
// -----------------------------------------------------------------------------
//  fetchFiles
// -----------------------------------------------------------------------------
- (RACSignal *)fetchFiles {
    return [self requestPath:@"files"
                  parameters:nil
                      method:@"GET"];
}

// -----------------------------------------------------------------------------
//  fetchSkin:
// -----------------------------------------------------------------------------
- fetchSkin:(NSString *)skinID {
    NSAssert(skinID, @"\"skinID\" cannot be 'nil'\n%s", __PRETTY_FUNCTION__);
    
    // Fetches a single
    RACSignal* (^fetchSkin)(NSString *) = ^(NSString *skinID) {
        return [self requestPath:@"skin_details"
                      parameters:@{@"skin_id" : skinID}
                          method:@"GET"];
    };
    
    // Returns a id<GW2Skin> instance
    id (^convertJSON)(NSDictionary *) = ^(NSDictionary *skinJSON) {
        return
        [NSClassFromString(@"_GW2Skin") objectWithID:skinID
                                                name:nil
                                  fromJSONDictionary:skinJSON
                                               error:nil];
    };
    
    // 1) Fetch the skin JSON;
    // 2) convert it;
    // 3) return a signal w/id<GW2Skin> instance
    return [fetchSkin(skinID) flattenMap:
            ^RACStream *(NSDictionary *skinJSON) {
                return [RACSignal return:convertJSON(skinJSON)];
            }];
}

// -----------------------------------------------------------------------------
//  fetchSkins:
// -----------------------------------------------------------------------------
- fetchSkins:(NSArray *)skinIDs {
    RACSignal *skinsSignal = skinIDs.rac_sequence.signal;
    return [skinsSignal flattenMap:^RACStream *(NSString *skinID) {
        return [[self fetchSkin:skinID] retry];
    }];
}

// -----------------------------------------------------------------------------
//  fetchImageForIconFile:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchImageForIconFile:(id<GW2IconFile>)iconFile {
    return [self fetchImageWithSignature:[iconFile iconFileSignature]
                                  fileID:[iconFile iconFileID]];
}

// -----------------------------------------------------------------------------
//  fetchImageWithSignature:fileID:
// -----------------------------------------------------------------------------
- (RACSignal *)fetchImageWithSignature:(NSString *)signature
                                fileID:(NSString *)fileID {
    NSAssert(signature, @"\"signature\" cannot be 'nil'\n%s", __PRETTY_FUNCTION__);
    NSAssert(fileID,    @"\"fileID\" cannot be 'nil'",        __PRETTY_FUNCTION__);
    
    return
    [[RACSignal startLazilyWithScheduler:[RACScheduler scheduler]
                                   block:^(id<RACSubscriber> subscriber) {
                                       NSURL *url =
                                       [NSURL URLWithString:
                                        [NSString stringWithFormat:@"https://render.guildwars2.com/file/%@/%@.png",
                                         signature, fileID]];
                                       
                                       NSData *imageData = [NSData dataWithContentsOfURL:url];
#if TARGET_OS_IPHONE
                                       UIImage * image = [UIImage imageWithData:imageData];
#else
                                       NSImage * image = [[NSImage alloc] initWithData:imageData];
#endif
                                       [subscriber sendNext:image];
                                       [subscriber sendCompleted];
                                   }]
     deliverOn:[RACScheduler mainThreadScheduler]];
}
@end

id<GW2ClientV1> GW2ClientV1(NSString *preferredLanguage) {
    // Ensure arguments are valid
    return [GW2ClientVersion1 clientWithPreferredLanguage:preferredLanguage];
};
