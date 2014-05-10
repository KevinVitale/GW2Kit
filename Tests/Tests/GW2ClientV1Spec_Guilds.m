//
//  GW2ClientV1Spec_Events.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 5/10/14.
//
//

#import "GW2SharedSpec.h"

SpecBegin(GW2ClientV1_Guilds)
describe(@"client guilds", ^ {
    id<GW2ClientV1> __block client;
    
    // -----------------------------------------------------------------------------
    //  before
    // -----------------------------------------------------------------------------
    before(^ {
        client = GW2ClientV1(nil);
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    // -----------------------------------------------------------------------------
    //  fetches guild details
    // -----------------------------------------------------------------------------
    it(@"fetches guild by name", ^AsyncBlock {
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
    
    // -----------------------------------------------------------------------------
    //  fetches guid details
    // -----------------------------------------------------------------------------
    it(@"fetches guild by id", ^AsyncBlock {
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
    
    // -----------------------------------------------------------------------------
    //  after
    // -----------------------------------------------------------------------------
    after(^ {
        client = nil;
    });
});
SpecEnd
