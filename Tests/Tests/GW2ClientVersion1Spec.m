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
describe(@"version 1 client", ^ {
    GW2ClientVersion1 * __block client;
    beforeAll(^ {
        client = [GW2ClientVersion1 clientWithPreferredLanguage:nil];
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    it(@"fetches events", ^AsyncBlock {
        [[[client
           fetchEvents:@{@"world_id" : @"1015"}]
          logNext]
         subscribeError:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches event names", ^AsyncBlock {
        [[[client fetchEventNames]
          logNext]
         subscribeError:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches maps names", ^AsyncBlock {
        [[[client fetchMapNames]
          logNext]
         subscribeError:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches world names", ^AsyncBlock {
        [[[client fetchWorldNames]
          logNext]
         subscribeError:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches event details", ^AsyncBlock {
        [[client fetchEventDetails:nil]
         subscribeNext:^(NSArray *events) {
             for(id event in events) {
                 NSLog(@"%@", event);
             };
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
});
SpecEnd