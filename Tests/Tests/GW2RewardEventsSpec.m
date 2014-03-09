//
//  GW2RewardEventsSpec.m
//  GW2Kit Tests
//
//  Created by Kevin Vitale on 3/9/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import <GW2Kit/GW2Kit.h>
#import <ReactiveCocoa.h>



SpecBegin(GW2RewardEvents)
describe(@"reward events", ^ {
    
    GW2ClientVersion1 *__block client;
    
    NSArray *rewardEventIDList =
    @[@"6BD7C8B0-2605-4819-9AE6-EF2849098090", // "Defeat Rhendak the Crazed."
      @"C876757A-EF3E-4FBE-A484-07FF790D9B05", // "Kill the megadestroyer before it blows everyone up."
      @"99254BA6-F5AE-4B07-91F1-61A9E7C51A51", // "Cover Keeper Jonez Deadrun as he performs the cleansing ritual."
      @"0464CB9E-1848-4AAA-BA31-4779A959DD71", // "Defeat the Claw of Jormag."
      @"95CA969B-0CC6-4604-B166-DBCCE125864F", // "Defeat the dredge commissar."
      @"295E8D3B-8823-4960-A627-23E07575ED96", // "Defeat the fire shaman and his minions."
      @"C5972F64-B894-45B4-BC31-2DEEA6B7C033", // "Defeat the great jungle wurm."
      @"9AA133DC-F630-4A0E-BB5D-EE34A2B306C2", // "Defeat the Inquest's golem Mark II."
      @"E1CC6E63-EFFE-4986-A321-95C89EA58C07", // "Defeat the Karka Queen threatening the settlements."
      @"F479B4CF-2E11-457A-B279-90822511B53B",
      @"5282B66A-126F-4DA4-8E9D-0D9802227B6D",
      @"4CF7AA6E-4D84-48A6-A3D1-A91B94CCAD56",
      @"6A6FD312-E75C-4ABF-8EA1-7AE31E469ABA", // "Defeat the possessed statue of Dwayna."
      @"2555EFCB-2927-4589-AB61-1957D9CC70C8", // "Defeat the Risen Priest of Balthazar before it can summon a horde of Risen."
      @"31CEBA08-E44D-472F-81B0-7143D73797F5", // "Defeat the shadow behemoth."
      @"E6872A86-E434-4FC1-B803-89921FF0F6D6", // "Defeat Ulgoth the Modniir and his minions."
      @"A0796EC5-191D-4389-9C09-E48829D1FDB2", // "Destroy the Eye of Zhaitan."
      @"33F76E9E-0BB6-46D0-A3A9-BE4CDFC4A3A4", // "Destroy the fire elemental created from chaotic energy fusing with the C.L.E.A.N. 5000's energy core."
      @"7E24F244-52AF-49D8-A1D7-8A1EE18265E0", // "Destroy the Risen Priest of Melandru."
      @"242BD241-E360-48F1-A8D9-57180E146789", // "Kill Admiral Taidha Covington."
      @"0372874E-59B7-4A8F-B535-2CF57B8E67E4", // "Kill the Corrupted High Priestess"
      @"B4E6588F-232C-4F68-9D58-8803D67E564D", // "Kill the Foulbear Chieftain and her elite guards before the ogres can rally."
      @"F7D9D427-5E54-4F12-977A-9809B23FBA99", // "Kill the Svanir shaman chief to break his control over the ice elemental."
      @"03BF176A-D59F-49CA-A311-39FC6F533F2F", // "Slay the Shatterer"
      @"568A30CF-8512-462F-9D67-647D69BEFAED"  // "Defeat Tequatl the Sunless."
      ];
    
    
    beforeAll(^ {
        
        // Check our event list
        expect(rewardEventIDList.count).to.equal(25);
        
        
        // Create our gw2 client (v1)
        client = [GW2ClientVersion1 clientWithPreferredLanguage:nil];
        expect(client.preferredLanguage).to.equal(@"en");
        
        setAsyncSpecTimeout(100);
    });
    
    it(@"should do something", ^AsyncBlock {
        
        [[[[client fetchEvents:@{ @"event_id" : rewardEventIDList.firstObject, @"world_id" : @1015 }]
           delay:1]
          repeat]
         subscribeNext:^(id<GW2EventState> eventState) {
             NSLog(@"%@", eventState);
         }
         error:^(NSError *error) {
         }
         completed:^{
         }];
    });
    
});
SpecEnd