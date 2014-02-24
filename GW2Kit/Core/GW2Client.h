//
//  GW2Client.h
//  
//
//  Created by Kevin Vitale on 2/22/14.
//
//

@import Foundation;
@class RACSignal;

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

+ (id<GW2Client>)clientWithVersion:(NSString *)version
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

/**
 *  @class GW2Client
 *  @abstract A concrete class used to communicate with all GW2 APIs.
 */
@interface GW2Client : NSObject <GW2Client>
@end