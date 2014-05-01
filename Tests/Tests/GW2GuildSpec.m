//
//  GW2GuildSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#import "GW2SharedSpec.h"
#import "GW2Guild.h"

SpecBegin(GW2Guild)
describe(@"guild", ^ {
    NSDictionary *__block guildDictionary;
    beforeAll(^ {
        // Convert it to an NSObject
        guildDictionary = GW2SpecLoadJSONFixture(@"guild_details");
        expect(guildDictionary.count).to.beGreaterThan(0);
    });
    
    it(@"instantiates from guild JSON", ^ {
        id<GW2Guild> guild = [NSClassFromString(@"_GW2Guild") objectWithID:nil
                                                                     name:nil
                                                       fromJSONDictionary:guildDictionary
                                                                    error:nil];
        // Check object integrity
        expect(guild).toNot.beNil();
        expect(guild.tag).equal(@"LA");
        expect(guild.name).equal(@"Veterans Of Lions Arch");
        expect(guild.objectID).equal(@"75FD83CF-0C45-4834-BC4C-097F93A487AF");
        expect([guild.emblem conformsToProtocol:@protocol(GW2GuildEmblem)]).to.beTruthy();
        
        NSDictionary *GuildJSON = [guild JSONRepresentation];
        expect(GuildJSON).equal(guildDictionary);
    });
});
SpecEnd