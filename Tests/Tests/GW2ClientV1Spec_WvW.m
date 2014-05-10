//
//  GW2ClientV1Spec_Events.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 5/10/14.
//
//

#import "GW2SharedSpec.h"

SpecBegin(GW2ClientV1_WvW)
describe(@"client wvw", ^ {
    id<GW2ClientV1> __block client;
    
    // -----------------------------------------------------------------------------
    //  before
    // -----------------------------------------------------------------------------
    before(^ {
        client = GW2ClientV1(nil);
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    // -----------------------------------------------------------------------------
    //  fetches WvW match
    // -----------------------------------------------------------------------------
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
    
    // -----------------------------------------------------------------------------
    //  fetches WvW match ups
    // -----------------------------------------------------------------------------
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
    
    // -----------------------------------------------------------------------------
    //  fetches WvW objectives names
    // -----------------------------------------------------------------------------
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

    
    // -----------------------------------------------------------------------------
    //  after
    // -----------------------------------------------------------------------------
    after(^ {
        client = nil;
    });
});
SpecEnd
