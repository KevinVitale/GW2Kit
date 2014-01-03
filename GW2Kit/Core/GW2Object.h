//
//  GW2Object.h
//  GW2Kit
//
//  Created by Kevin Vitale on 12/31/13.
//
//

#import <Mantle/Mantle.h>

/**
 *  Objects returned by the GW2 API which have an 'id' and a 'name'.
 *
 *  This includes:
 *      - event_names
 *      - world_names
 *      - map_naes
 *
 *  The response looks like:
 *      {
 *          "name"  : " ... ",
 *          "id"    : " ... "
 *      }
 *
 *  The value of 'name' can be a string, in the case of events.
 *  The value of 'name' can be a number, in the case of world and maps.
 */
@interface GW2Object : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) id objectID;
@property (nonatomic, copy, readonly) NSString *name;

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
@end