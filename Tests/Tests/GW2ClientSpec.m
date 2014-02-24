//
//  GW2ColorSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2Client.h"
#import "GW2Object.h"
#import <ReactiveCocoa.h>

SpecBegin(GW2Client)
describe(@"client", ^ {
    id<GW2Client> __block client;
    beforeAll(^ {
        client = [GW2Client clientWithVersion:@"v1"
                            preferredLanguage:nil];
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    it(@"fetches map names", ^AsyncBlock {
        [[[[client requestPath:@"map_names"
                    parameters:nil
                        method:@"GET"]
           map:^id(id value) {
               NSArray *maps = (NSArray *)[value first];
               return [maps.rac_sequence map:^id(NSDictionary *mapName) {
                   return
                   [NSClassFromString(@"_GW2Object") objectWithID:@([mapName[@"id"] integerValue])
                                                             name:nil
                                               fromJSONDictionary:mapName
                                                            error:nil];
               }].array;
           }]
          logNext]
         subscribeError:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches with parameters", ^AsyncBlock {
        [[[client requestPath:@"maps"
                   parameters:nil
                       method:@"GET"]
          map:^id(id value) {
              NSArray *maps = (NSArray *)[value first][@"maps"];
              return [maps.rac_sequence map:^id(RACTuple *map) {
                  return
                  [NSClassFromString(@"_GW2MapBasic") objectWithID:@([[map first] integerValue])
                                                              name:nil
                                                fromJSONDictionary:[map second]
                                                             error:nil];
              }].array;
          }]
         
         subscribeNext:^(id x) {
             NSLog(@"%@", [x valueForKey:@"name"]);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fails gracefully", ^AsyncBlock {
        [[[client requestPath:@"bogus"
                   parameters:nil
                       method:@"GET"]
          logError]
         subscribeError:^(NSError *error) {
             expect(error).toNot.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
});
SpecEnd