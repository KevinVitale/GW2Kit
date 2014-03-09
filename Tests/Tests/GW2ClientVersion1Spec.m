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
    
    it(@"fetches guild details", ^AsyncBlock {
        [[client fetchGuildWithName:@"New Tyrian Order"]
         subscribeNext:^(id guild) {
             NSLog(@"%@", guild);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches guild details", ^AsyncBlock {
        [[client fetchGuildWithID:@"6E68F577-CB39-4E1D-ADED-B7C5C39E2315"]
         subscribeNext:^(id guild) {
             NSLog(@"%@", guild);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches continents", ^AsyncBlock {
        [[client fetchContinents]
         subscribeNext:^(id continent) {
             NSLog(@"%@", continent);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches maps", ^AsyncBlock {
        [[client fetchMap:@15]
         subscribeNext:^(id map) {
             NSLog(@"%@", map);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches maps", ^AsyncBlock {
        [[client fetchMaps]
         subscribeNext:^(id maps) {
             NSLog(@"%@", maps);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches map floor", ^AsyncBlock {
        [[client fetchMapFloor:@1 inContinent:@1]
         subscribeNext:^(id mapFloor) {
             NSLog(@"%@", mapFloor);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches wvw match", ^AsyncBlock {
        [[client fetchWvWMatchDetails:@"1-4"]
         subscribeNext:^(id wvwMatch) {
             NSLog(@"%@", wvwMatch);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches wvw match ups", ^AsyncBlock {
        [[client fetchWvWMatches]
         subscribeNext:^(id wvwMatch) {
             NSLog(@"%@", wvwMatch);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches wvw objectives names", ^AsyncBlock {
        [[client fetchWvWObjectiveNames]
         subscribeNext:^(id names) {
             NSLog(@"%@", names);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches colors", ^AsyncBlock {
        [[client fetchColors]
         subscribeNext:^(id colors) {
             NSLog(@"%@", colors);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches files", ^AsyncBlock {
        [[client fetchFiles]
         subscribeNext:^(id files) {
             NSLog(@"%@", files);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    it(@"fetches image", ^AsyncBlock {
        [[client fetchImageWithSignature:@"B3DEEC72BBEF0C6FC6FEF835A0E275FCB1151BB7"
                                  fileID:@"102439"]
         subscribeNext:^(id image) {
             NSLog(@"%@", image);
         }
         error:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    afterAll(^ {
        client = nil;
    });
});
SpecEnd