//
//  GW2GuildSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/7/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2Guild.h"

SpecBegin(GW2Guild)
describe(@"guild", ^ {
    NSDictionary *__block guildDictionary;
    beforeAll(^ {
        // Pull the .json file from the bundle
        NSURL *guildURL = [[NSBundle bundleForClass:self.class] URLForResource:@"guild_details" withExtension:@"json"];
        expect(guildURL).toNot.beNil();
        
        // Convert it to an NSObject
        id guildJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:guildURL] options:0 error:nil];
        
        // Verify a few basic things
        expect(guildJSON).toNot.beNil();
        expect([guildJSON class]).to.beSubclassOf([NSDictionary class]);
        
        // Extract the array of event states
        guildDictionary = guildJSON;
        expect(guildDictionary.count).toNot.beNil();
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