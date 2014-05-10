//
//  GW2ClientV1Spec_Events.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 5/10/14.
//
//

#import "GW2SharedSpec.h"

SpecBegin(GW2ClientV1_Wardrobe)
describe(@"client wardrobe", ^ {
    id<GW2ClientV1> __block client;
    
    // -----------------------------------------------------------------------------
    //  before
    // -----------------------------------------------------------------------------
    before(^ {
        client = GW2ClientV1(nil);
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    // -----------------------------------------------------------------------------
    //  fetches skins
    // -----------------------------------------------------------------------------
    it(@"fetches skins", ^AsyncBlock {
        NSArray *skinIDs = ({
            NSData *skinsJSON = ({
                NSString *skinsURL = @"https://api.guildwars2.com/v1/skins.json";
                [NSData dataWithContentsOfURL:[NSURL URLWithString:skinsURL]];
            });
            
            NSDictionary *response =
            [NSJSONSerialization JSONObjectWithData:skinsJSON
                                            options:0
                                              error:nil];
            response[@"skins"];
        });
        
        [[[client fetchSkins:skinIDs] take:5]
         subscribeNext:^(id<GW2Skin> skin) {
             NSLog(@"%@", skin);
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
