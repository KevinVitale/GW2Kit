//
//  GW2Client.m
//
//
//  Created by Kevin Vitale on 2/22/14.
//
//

#import "GW2Client.h"
#import "CMDQueryStringSerialization.h"
#import <ReactiveCocoa.h>
#import <RACEXTScope.h>


@interface GW2Client ()
@property (copy, nonatomic, readwrite) NSString *version;
@property (copy, nonatomic, readwrite) NSString *preferredLanguage;
@property (copy, nonatomic, readwrite) NSString *hostname;
@property (strong, nonatomic) NSOperationQueue *queue;
@end

@implementation GW2Client

#pragma mark - Initialization
- (id)init {
    self = super.init;
    if(self) {
        self.queue = NSOperationQueue.new;
        self.preferredLanguage = @"en";
    }
    return self;
}
- (id)initWithVersion:(NSString *)version
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

+ (id<GW2Client>)clientWithVersion:(NSString *)version
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
              
              // Construct our request (side effect: this signs the request)
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
