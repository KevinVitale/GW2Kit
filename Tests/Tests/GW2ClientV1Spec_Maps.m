//
//  GW2ClientV1Spec_Events.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 5/10/14.
//
//

#import "GW2SharedSpec.h"

SpecBegin(GW2ClientV1_Maps)
describe(@"client maps", ^ {
    id<GW2ClientV1> __block client;
    
    // -----------------------------------------------------------------------------
    //  before
    // -----------------------------------------------------------------------------
    before(^ {
        client = GW2ClientV1(nil);
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    // -----------------------------------------------------------------------------
    //  fetches maps names
    // -----------------------------------------------------------------------------
    it(@"fetches maps names", ^AsyncBlock {
        [[[client fetchMapNames] logNext]
         subscribeError:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    // -----------------------------------------------------------------------------
    //  fetches continents
    // -----------------------------------------------------------------------------
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
    
    // -----------------------------------------------------------------------------
    //  fetches maps
    // -----------------------------------------------------------------------------
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
    
    // -----------------------------------------------------------------------------
    //  fetches multiple maps
    // -----------------------------------------------------------------------------
    it(@"fetches multiiple maps", ^AsyncBlock {
        [[[client fetchMaps] take:5]
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
    
    // -----------------------------------------------------------------------------
    //  fetches map floor
    // -----------------------------------------------------------------------------
    it(@"fetches map floor", ^AsyncBlock {
        [[[client fetchMapFloor:@1 inContinent:@1] take:1]
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

    
    // -----------------------------------------------------------------------------
    //  after
    // -----------------------------------------------------------------------------
    after(^ {
        client = nil;
    });
});
SpecEnd
