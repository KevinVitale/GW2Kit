//
//  GW2Object.h
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

/**
 *  @protocol GW2Object
 *  @discussion Adopted by all GW2Kit objects returned by the service.
 */
@protocol GW2Object <NSObject>
@required
/**
 *  @property objectID
 *  @discussion A unique-identifier for all objects.
 */
@property (copy, nonatomic, readonly) id objectID;

/**
 *  @property name
 *  @discussion A string identifier for all objects.
 */
@property (copy, nonatomic, readonly) NSString *name;

/**
 *  Wraps calls to the @p MTLJSONAdapter, but allows the caller to specify the
 *  instance's @p objectID and @p name values.
 *
 *  @param objectID       The unique identifier for the object.
 *  @param name           The human-readable name for the object.
 *  @param JSONDictionary The JSON representation returned by the GW2 API.
 *  @param error          If not @p NULL, this may be set to an error that occurs during
 *                        parsing or initializing an instance of `modelClass`.
 *
 *  @return Returns a new @p GW2Object. 
 *
 *  @note This is the same as calling:
 *  @code
 *      +[MTLJSONAdapter modelOfClass:fromJSONDictionary:error]
 *  @endcode
 *  but has the added benefit of being able to externally define the @p objectID,
 *  as well as the @p name.
 *
 *  @warning If the JSON dictionary contains values for either @p objectID or @p name,
 *        then the caller's provided values will be ignored.
 */
+(instancetype)objectWithID:(id)objectID
                       name:(NSString *)name
         fromJSONDictionary:(NSDictionary *)JSONDictionary
                      error:(NSError **)error;


@optional
/**
 *  @return JSON Dictionary.
 */
- (NSDictionary *)JSONRepresentation;
@end