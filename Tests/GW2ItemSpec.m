//
//  GW2ItemSpec.m
//  GW2Kit
//
//  Created by Kevin Vitale on 1/9/14.
//
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "GW2Item.h"
#import "GW2ItemTypeWeapon.h"

SpecBegin(GW2Item)

describe(@"item", ^ {
    NSDictionary *__block itemDetailJSON;
    beforeAll(^ {
        NSURL *itemJSONURL = [[NSBundle bundleForClass:self.class] URLForResource:@"item_details" withExtension:@"json"];
        itemDetailJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:itemJSONURL] options:0 error:nil];
        expect(itemDetailJSON).toNot.beNil();
    });
    
    it(@"initializes from JSON", ^ {
        id<GW2Item> item = [NSClassFromString(@"_GW2Item") objectWithID:nil
                                                                  name:nil
                                                    fromJSONDictionary:itemDetailJSON
                                                                 error:nil];
        expect(item).toNot.beNil();
        expect(item.objectID).equal(28445);
        expect(item.name).equal(@"Strong Bow of Fire");
        expect(item.description).equal(@"");
        expect(item.type).equal(@"Weapon");
        expect(item.level).equal(44);
        expect(item.rarity).equal(@"Masterwork");
        expect(item.vendorValue).equal(120);
        expect(item.iconFileID).equal(65015);
        expect(item.iconFileSignature).equal(@"C6110F52DF5AFE0F00A56F9E143E9732176DDDE9");
        expect(item.gameTypes.count).equal(4);
        
        NSArray *gameTypes = @[@"Activity", @"Dungeon", @"Pve", @"Wvw"];
        expect(item.gameTypes).equal(gameTypes);
        expect(item.gameTypes).to.contain(@"Activity");
        expect(item.flags).to.contain(@"SoulBindOnUse");
        expect(item.restrictions.count).equal(0);
    });
    
    it(@"initializes item type from JSON", ^ {
        id<GW2ItemTypeWeapon> itemType = [NSClassFromString(@"_GW2ItemTypeWeapon") objectWithID:nil
                                                                                           name:nil
                                                                             fromJSONDictionary:itemDetailJSON[@"weapon"]
                                                                                          error:nil];
        expect(itemType).toNot.beNil();
        expect(itemType.objectID).to.beNil();
        expect(itemType.name).equal(@"LongBow");
        expect(itemType.damageType).equal(@"Physical");
        expect(itemType.minimumPower).equal(385);
        expect(itemType.maximumPower).equal(452);
        expect(itemType.defense).equal(0);
        expect(itemType.infusionSlots).toNot.beNil();
        expect(itemType.infixUpgrade).toNot.beNil();
        expect([itemType.infixUpgrade conformsToProtocol:@protocol(GW2ItemInfixUpgrade)]).to.beTruthy();
        expect([itemType.infixUpgrade.attributes.firstObject conformsToProtocol:@protocol(GW2ItemInfixUpgradeAttribute)]).to.beTruthy();
    });
    
    it(@"validates type", ^ {
        NSDictionary *json = @
        {
            @"type" : @"Kevin"
        };
        id<GW2Item> item = [NSClassFromString(@"_GW2Item") objectWithID:nil
                                                                   name:nil
                                                     fromJSONDictionary:json
                                                                  error:nil];
        expect(item).toNot.beNil();
    });
});
SpecEnd