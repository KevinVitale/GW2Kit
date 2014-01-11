//
//  GW2Object.h
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

/**
 *  GW2Object, protocol adopted by all GW2Kit objects returned by the service.
 */
@protocol GW2Object <NSObject>
@required
/**
 *  @param objectID unique-identifier for all objects.
 *  @param name     string identifier for all objects.
 */
@property (copy, nonatomic, readonly)       id objectID;
@property (copy, nonatomic, readonly) NSString *name;

/**
 *  Wraps calls to the MTLJSONAdapter, but allows the caller to specify the
 *  instance's 'objectID' and 'name' values.
 *
 *  @note If the JSON dictionary contains values for either 'objectID' or 'name',
 *        then the caller's provided values will be ignored.
 *
 *  @param objectID       The unique identifier for the object.
 *  @param name           The human-readable name for the object.
 *  @param JSONDictionary The JSON representation returned by the GW2 API.
 *  @param error          If not NULL, this may be set to an error that occurs during
 *                        parsing or initializing an instance of `modelClass`.
 *
 *  @return This is the same as calling:
 *      +[MTLJSONAdapter modelOfClass:fromJSONDictionary:error],
 *  but has the added benefit of being able to externally define the object's ID,
 *  as well as its name.
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