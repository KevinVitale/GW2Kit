//
//  GW2Color.h
//  GW2Kit
//
//  Created by Kevin Vitale on 6/1/13.
//
//

#import <Foundation/Foundation.h>

@class RKMapping;

@interface GW2Color : NSObject
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *name;
@property (strong, readonly, nonatomic) id defaultColor;
@property (strong, readonly, nonatomic) id clothColor;
@property (strong, readonly, nonatomic) id leatherColor;
@property (strong, readonly, nonatomic) id metalColor;

+ (RKMapping *)mappingObject;
@end
