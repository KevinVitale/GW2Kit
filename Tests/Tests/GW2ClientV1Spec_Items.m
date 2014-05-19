//
//  GW2ClientV1Spec_Events.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 5/10/14.
//
//

#import "GW2SharedSpec.h"

SpecBegin(GW2ClientV1_Items)
describe(@"client items", ^ {
    id<GW2ClientV1> __block client;
    
    // -----------------------------------------------------------------------------
    //  before
    // -----------------------------------------------------------------------------
    before(^ {
        setAsyncSpecTimeout(1000000.f);
        client = GW2ClientV1(nil);
        expect(client.preferredLanguage).to.equal(@"en");
    });
    
    // -----------------------------------------------------------------------------
    //  fetches colors
    // -----------------------------------------------------------------------------
    it(@"fetches items", ^AsyncBlock {
        NSArray *itemIDs = ({
            NSData *data = [NSData dataWithContentsOfURL:({
                [NSURL URLWithString:@"https://api.guildwars2.com/v1/items.json"];
            })];
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil][@"items"];
        });
        
        RACSequence *sequence   = itemIDs.rac_sequence;
        NSString *urlString     = @"https://api.guildwars2.com/v1/item_details.json?item_id=";
        NSString *urlString2    = @"https://tradingpost-live.ncplatform.net/ws/search.json?ids=";
        
        RACSignal *signal = ({
            [[[[[sequence signal] take:1] deliverOn:[RACScheduler scheduler]] delay:1]
             flattenMap:^RACStream *(NSNumber *itemID) {
                 return
                 [RACSignal zip:
                  @[({
                     NSURL *url = [NSURL URLWithString:[urlString stringByAppendingString:itemID.stringValue]];
                     [[NSURLConnection rac_sendAsynchronousRequest:({
                         [NSURLRequest requestWithURL:url];
                     })] map:^id(RACTuple *tuple) {
                         return [NSJSONSerialization JSONObjectWithData:tuple.last
                                                                options:0
                                                                  error:nil];
                     }];
                 })
                    ,
                    ({
                     NSURL *url = [NSURL URLWithString:[urlString2 stringByAppendingString:itemID.stringValue]];
                     [[NSURLConnection rac_sendAsynchronousRequest:({
                         NSMutableURLRequest *request = [[NSURLRequest requestWithURL:url] mutableCopy];
                         [request setValue:@"s="
                        forHTTPHeaderField:@"Cookie"];
                         [request copy];
                     })] map:^id(RACTuple *tuple) {
                         return [NSJSONSerialization JSONObjectWithData:tuple.last
                                                                options:0
                                                                  error:nil];
                     }];
                 })
                    ]];
             }];
        });
        
        [signal subscribeNext:^(id x) {
            NSLog(@"%@", x);
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
        setAsyncSpecTimeout(10.f);
        client = nil;
    });
});
SpecEnd
