//
//  GW2IconFile.h
//  
//
//  Created by Kevin Vitale on 5/1/14.
//
//

@import Foundation;

#pragma mark - Icon File
// -----------------------------------------------------------------------------
//  GW2IconFile, Protocol
// -----------------------------------------------------------------------------
/**
 *  @protocol   GW2IconFile
 *  @discussion Represents an item's icon. Used with the rendering service.
 */
@protocol GW2IconFile <NSObject>
@required

/**
 *  @property   iconFileID
 */
@property (copy, nonatomic, readonly)   NSString *iconFileID;

/**
 *  @property   iconFileSignature
 */
@property (copy, nonatomic, readonly)   NSString *iconFileSignature;
@end
