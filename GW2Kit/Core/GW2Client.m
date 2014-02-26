//
//  GW2Client.m
//
//
//  Created by Kevin Vitale on 2/22/14.
//
//

#import "GW2Client.h"
#import "GW2Object.h"
#import "CMDQueryStringSerialization.h"
#import <ReactiveCocoa.h>
#import <RACEXTScope.h>


@interface GW2Client ()
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

/**
 *  @property queue
 *  @discussion The operation queue which the client makes asynchronous requests on.
 */
@property (strong, nonatomic) NSOperationQueue *queue;

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

#pragma mark - Generic Client
@implementation GW2Client

#pragma mark - Initialization
- (instancetype)init {
    self = super.init;
    if(self) {
        self.queue = NSOperationQueue.new;
        self.preferredLanguage = @"en";
    }
    return self;
}
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

+ (instancetype)clientWithVersion:(NSString *)version
                preferredLanguage:(NSString *)languageCode {
    // Ensure arguments are valid
    NSAssert(version, @"\"version\" can not be 'nil'\n%s", __PRETTY_FUNCTION__);
    
    // Create our client
    id<GW2Client>client = [[self.class alloc] initWithVersion:version
                                            preferredLanguage:languageCode];
    ((GW2Client *)client).hostname = ({
        [NSString stringWithFormat:@"api.guildwars2.com/%@", version];
    });
    return client;
}

#pragma mark - Requests
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

- (RACSignal *)requestPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                    method:(NSString *)method {
    @weakify(self);
    return
    [[RACSignal createSignal:
      ^RACDisposable *(id<RACSubscriber> subscriber) {
          @strongify(self);
          
          NSBlockOperation *operation =
          [NSBlockOperation blockOperationWithBlock:^{
              
              NSURLRequest *request = [self requestWithMethod:method
                                                         path:path
                                                   parameters:parameters];
              NSURLResponse *response;
              NSError *error;
              
              NSData *result =
              [NSURLConnection sendSynchronousRequest:request
                                    returningResponse:&response
                                                error:&error];
              
              
              // Always try to parse the result as JSON
              id json;
              if(result) {
                  json = [NSJSONSerialization JSONObjectWithData:result
                                                         options:0
                                                           error:&error];
                  
              }
              
              // Check for errors
              if(error || ({
                  id error;
                  if([json respondsToSelector:@selector(objectForKeyedSubscript:)]) {
                      error = json[@"error"];
                  }
                  error;
              })) {
                  
                  // If the response was, itself, an error, convert it.
                  if(json[@"error"]) {
                      error = [NSError errorWithDomain:@"GW2APIErrorDomain"
                                                  code:[json[@"error"] integerValue]
                                              userInfo:json];
                  }
                  
                  // Terminate with an error
                  [subscriber sendError:error];
              }
              
              // Send the JSON and the connection's response
              else {
                  [subscriber sendNext:RACTuplePack(json, request, response)];
                  [subscriber sendCompleted];
              }
          }];
          
          // Queue the network request
          [self.queue addOperation:operation];
          
          // Return a cancellable operation as the 'disposable'.
          return
          [RACDisposable disposableWithBlock:^{
              [operation cancel];
          }];
      }]
     deliverOn:RACScheduler.mainThreadScheduler];
}
@end

#pragma mark - Version 1 Client
@implementation GW2ClientVersion1
+ (instancetype)clientWithPreferredLanguage:(NSString *)languageCode {
    return [self clientWithVersion:@"v1"
                 preferredLanguage:languageCode];
}

#pragma mark - Events
- (RACSignal *)fetchEvents:(NSDictionary *)parameters {
    NSSet *exceptedSet  = [NSSet setWithArray:@[@"world_id", @"map_id", @"event_id"]];
    NSSet *keySet       = [NSSet setWithArray:parameters.allKeys];
    if(![keySet intersectsSet:exceptedSet]) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:@"Invalid key values in parameters"
                                     userInfo:parameters];
    }
    
    return
    [[self requestPath:@"events"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSArray *events = response[0][@"events"];
         return
         [RACSignal return:
          [[events.rac_sequence map:^id(NSDictionary *eventJSON) {
             return
             [NSClassFromString(@"_GW2EventState") objectWithID:eventJSON[@"event_id"]
                                                           name:nil
                                             fromJSONDictionary:eventJSON
                                                          error:nil];
         }]
           array]
          ];
     }];
}

- (RACSignal *)fetchEventNames {
    return
    [[self requestPath:@"event_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSArray *names = response[0];
         return
         [RACSignal return:
          [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:namesJSON[@"id"]
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
           array]
          ];
     }];
}

- (RACSignal *)fetchMapNames {
    return
    [[self requestPath:@"map_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSArray *names = response[0];
         return
         [RACSignal return:
          [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:namesJSON[@"id"]
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
           array]
          ];
     }];
}

- (RACSignal *)fetchWorldNames {
    return
    [[self requestPath:@"world_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSArray *names = response[0];
         return
         [RACSignal return:
          [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:namesJSON[@"id"]
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
           array]
          ];
     }];
}

- (RACSignal *)fetchEventDetails:(NSString *)eventID {
    NSDictionary *parameters;
    (eventID ? ({ parameters = @{@"event_id" : eventID}; }) : nil);
    return
    [[self requestPath:@"event_details"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSArray *events = response[0][@"events"];
         return
         [RACSignal return:
          [[events.rac_sequence map:^id(RACTuple *event) {
             return
             [NSClassFromString(@"_GW2Event") objectWithID:event[0]
                                                      name:nil
                                        fromJSONDictionary:event[1]
                                                     error:nil];
         }]
           array]
          ];
     }];
}

#pragma mark - Guilds
- (RACSignal *)fetchGuildWithID:(NSString *)guildID {
    NSDictionary *parameters;
    (guildID ? ({ parameters = @{@"guild_id" : guildID}; }) : nil);
    return
    [[self requestPath:@"guild_details"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSDictionary *guildJSON = response[0];
         return
         [RACSignal return:
          [NSClassFromString(@"_GW2Guild") objectWithID:nil
                                                   name:nil
                                     fromJSONDictionary:guildJSON
                                                  error:nil]];
     }];
}

- (RACSignal *)fetchGuildWithName:(NSString *)guildName {
    NSDictionary *parameters;
    (guildName ? ({ parameters = @{@"guild_name" : guildName}; }) : nil);
    return
    [[self requestPath:@"guild_details"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSDictionary *guildJSON = response[0];
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
- (RACSignal *)fetchContinents {
    return
    [[self requestPath:@"continents"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSDictionary *continents = response[0][@"continents"];
         return
         [RACSignal return:
          [[continents.rac_sequence map:^id(RACTuple *continent) {
             return
             [NSClassFromString(@"_GW2MapContinent") objectWithID:continent[0]
                                                             name:nil
                                               fromJSONDictionary:continent[1]
                                                            error:nil];
         }]
           array]
          ];
     }];
}

- (RACSignal *)fetchMaps {
    return [self fetchMap:nil];
}
- (RACSignal *)fetchMap:(id)mapID {
    NSDictionary *parameters;
    (mapID ? ({ parameters = @{@"map_id" : mapID}; }) : nil);
    return
    [[self requestPath:@"maps"
            parameters:parameters
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSDictionary *maps = response[0][@"maps"];
         return
         [RACSignal return:
          [[maps.rac_sequence map:^id(RACTuple *map) {
             return
             [NSClassFromString(@"_GW2MapBasic") objectWithID:map[0]
                                                         name:nil
                                           fromJSONDictionary:map[1]
                                                        error:nil];
         }]
           array]
          ];
     }];
}
- (RACSignal *)fetchMapFloor:(id)floor inContinent:(id)continentID {
    
    NSAssert(floor,         @"\"floor\" cannot be 'nil'\n%s", floor, __PRETTY_FUNCTION__);
    NSAssert(continentID,   @"\"continentID\" cannot be 'nil'", continentID, __PRETTY_FUNCTION__);
    
    return
    [[self requestPath:@"map_floor"
            parameters:
      @{@"floor" : floor,
        @"continent_id" : continentID
        }
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSDictionary *mapFloorJSON = response[0];
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
- (RACSignal *)fetchWvWMatches {
    return
    [[self requestPath:@"wvw/matches"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSArray *matches = response[0][@"wvw_matches"];
         return
         [RACSignal return:
          [[matches.rac_sequence map:^id(NSDictionary *match) {
             return
             [NSClassFromString(@"_GW2WvWMatchUp") objectWithID:nil
                                                           name:nil
                                             fromJSONDictionary:match
                                                          error:nil];
         }]
           array]
          ];
     }];
}
- (RACSignal *)fetchWvWMatchDetails:(id)matchID {
    NSAssert(matchID, @"\"matchID\" cannot be 'nil'\n%s", matchID, __PRETTY_FUNCTION__);
    
    return
    [[self requestPath:@"wvw/match_details"
            parameters:@{@"match_id" : matchID}
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSDictionary *matchJSON = response[0];
         return
         [RACSignal return:
          [NSClassFromString(@"_GW2WvWMatch") objectWithID:matchJSON[@"match_id"]
                                                      name:nil
                                        fromJSONDictionary:matchJSON
                                                     error:nil]
          ];
     }];
}
- (RACSignal *)fetchWvWObjectiveNames {
    return
    [[self requestPath:@"wvw/objective_names"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSArray *names = response[0];
         return
         [RACSignal return:
          [[names.rac_sequence map:^id(NSDictionary *namesJSON) {
             return
             [NSClassFromString(@"_GW2Object") objectWithID:nil
                                                       name:nil
                                         fromJSONDictionary:namesJSON
                                                      error:nil];
         }]
           array]
          ];
     }];
}

#pragma mark - Misc
- (RACSignal *)fetchBuild {
    return [self requestPath:@"build"
                  parameters:nil
                      method:@"GET"];
}
- (RACSignal *)fetchColors {
    return
    [[self requestPath:@"colors"
            parameters:nil
                method:@"GET"]
     flattenMap:^RACStream *(RACTuple *response) {
         NSDictionary *colors = response[0][@"colors"];
         return
         [RACSignal return:
          [[colors.rac_sequence map:^id(RACTuple *color) {
             return
             [NSClassFromString(@"_GW2Color") objectWithID:color[0]
                                                      name:nil
                                        fromJSONDictionary:color[1]
                                                     error:nil];
         }]
           array]
          ];
     }];
}
- (RACSignal *)fetchFiles {
    return [self requestPath:@"files"
                  parameters:nil
                      method:@"GET"];
}


#pragma mark - Services
/* tile service */
- (RACSignal *)fetchImageWithSignature:(NSString *)signature
                                fileID:(NSString *)fileID {
    NSAssert(signature, @"\"signature\" cannot be 'nil'\n%s", signature, __PRETTY_FUNCTION__);
    NSAssert(fileID, @"\"fileID\" cannot be 'nil'", fileID, __PRETTY_FUNCTION__);
    
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