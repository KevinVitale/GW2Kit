//
//  GW2ColorSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/2/14.
//
//

#import "GW2SharedSpec.h"

SpecBegin(GW2Client)
describe(@"version 1 client", ^ {
    id<GW2ClientV1> __block client;
    
    // -----------------------------------------------------------------------------
    //  before
    // -----------------------------------------------------------------------------
    before(^ {
        client = GW2ClientV1(nil);
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    // -----------------------------------------------------------------------------
    //  fetches world names
    // -----------------------------------------------------------------------------
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
    
    // -----------------------------------------------------------------------------
    //  fetches files
    // -----------------------------------------------------------------------------
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
    
    // -----------------------------------------------------------------------------
    //  after
    // -----------------------------------------------------------------------------
    after(^ {
        client = nil;
    });
});
SpecEnd