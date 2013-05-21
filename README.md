# GW2Kit

GW2Kit is a Objective-C framework for clients of the Guild Wars 2 API, meant for iOS and Mac OS X. It relies on [RestKit](https://github.com/RestKit/RestKit) and [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa).

## Overview

Guild Wars 2 API documentation is provided [here](https://forum-en.guildwars2.com/forum/community/api/API-Documentation/first#post2028044).

## Getting Started

**Getting the code:**

	$ cd /path/to/MyApplication
	# If this is a new project, initialize git...
	$ git init
	$ git submodule add git@github.com:KevinVitale/GW2Kit.git
	$ git submodule update --init --recursive
	$ open GW2Kit
	
**Running the tests:**

Only the frameworks are provided (no app provided, at the moment). Run the test by selecting `GW2KitTests` scheme, and hitting **⌘+U**.

## Example

### Item detail

Looking up __The Hunter__:

	NSString *itemID = @"29175";
	[GW2 itemDetailForID:itemID completion:^(NSError *error, GW2ItemDetail *itemDetail) {
	    printf("%s", [itemDetail description].UTF8String);
	}];

Output:

	----------------------------------------------------------------------------------------------------
	[#29175] The Hunter
	----------------------------------------------------------------------------------------------------
	| rarity                                  : Exotic
	| vendorValue                             : 396
	| gameTypes                               : (
	    Activity,
	    Dungeon,
	    Pve,
	    Wvw
	)
	| flags                                   : (
	    HideSuffix
	)
	| restrictions                            : (
	)
	| text                                    : <c=@flavor>This weapon is used to craft the legendary rifle The Predator</c>
	| type                                    : Weapon
	| itemID                                  : 29175
	| name                                    : The Hunter
	| info                                    : {
	    "damage_type" = Physical;
	    defense = 0;
	    "infix_upgrade" =     {
	        attributes =         (
	                        {
	                attribute = Power;
	                modifier = 179;
	            },
	                        {
	                attribute = Precision;
	                modifier = 128;
	            },
	                        {
	                attribute = CritDamage;
	                modifier = 9;
	            }
	        );
	        buff = "";
	    };
	    "infusion_slots" =     (
	    );
	    "max_power" = 1205;
	    "min_power" = 986;
	    "suffix_item_id" = 24561;
	    type = Rifle;
	}
	
### Event States:

	// Find event states in 'Kessex Hills' on 'Maguuma'
	[GW2 eventStatesWithParameters:@{@"world_id" : @"1005", @"map_id" : @"23"}
	                    completion:^(NSError *error, id states) {
	                        for(GW2EventStatus *status in states) {
	                            printf("%s", [status description].UTF8String);
	                        }
	                    }];
	
### Output:

	mapID                                   : 23
	state                                   : Success
	eventID                                 : F090E0ED-AFC3-4AEE-A90C-91A57FB27F6D
	worldID                                 : 1005

	mapID                                   : 23
	state                                   : Warmup
	eventID                                 : 3CE76F6D-A926-4BB2-9124-D5AA85B1E68A
	worldID                                 : 1005

	mapID                                   : 23
	state                                   : Warmup
	eventID                                 : F5841085-D765-4CBF-8E22-EF3521C6813D
	worldID                                 : 1005

	mapID                                   : 23
	state                                   : Warmup
	eventID                                 : E7D9AD09-44CE-42E0-BB85-9E62D59928A6
	worldID                                 : 1005

	... *many, many more...*

## License

GW2Kit is licensed under the terms of the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). Please see the [LICENSE](LICENSE) file for full details.

## Credits

GW2Kit is brought to you by [Kevin Vitale](https://github.com/KevinVitale).