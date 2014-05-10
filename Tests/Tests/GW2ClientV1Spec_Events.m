//
//  GW2ClientV1Spec_Events.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 5/10/14.
//
//

#import "GW2SharedSpec.h"

SpecBegin(GW2ClientV1_Events)
describe(@"client events", ^ {
    id<GW2ClientV1> __block client;
    
    // -----------------------------------------------------------------------------
    //  before
    // -----------------------------------------------------------------------------
    before(^ {
        client = GW2ClientV1(nil);
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    // -----------------------------------------------------------------------------
    //  fetches event names
    // -----------------------------------------------------------------------------
    it(@"fetches event names", ^AsyncBlock {
        [[[[client fetchEventNames] take:5] logNext]
         subscribeError:^(NSError *error) {
             expect(error).to.beNil();
             done();
         }
         completed:^{
             done();
         }];
    });
    
    // -----------------------------------------------------------------------------
    //  fetches event details
    // -----------------------------------------------------------------------------
    it(@"fetches event details", ^AsyncBlock {
        [[[client fetchEventDetails:nil] take:5]
         subscribeNext:^(id<GW2Event> event) {
             NSLog(@"%@", event);
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
