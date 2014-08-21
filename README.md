# GW2Kit

## ABANDONMENT NOTICE

ArenaNet has let their APIs die on the vine. After almost 12 months of waiting (and counting), I've lost all interest in this project. Apparently there *is* a version 2 coming "soon". If it ever does, this project will get rebooted.

### What is GW2Kit?

GW2Kit is a Objective-C framework that provides access to the offical Guild Wars 2 API (`api.guildwars2.com`). It is has support for both iOS and OS X.

### Introduction

The Official Guild Wars 2 API was released on May 20th, 2013. Posted by ArenaNet Lead Programmer [Cliff Spradlin](https://forum-en.guildwars2.com/forum/community/api/API-Documentation/first#post2028044), it provides third-party application the ability to query real-time, in-game data.

- [The API documentation](https://forum-en.guildwars2.com/forum/community/api/API-Documentation/first#post2028044) (Guild Wars 2 Forums)
- [Guild Wars 2 API wiki page](http://wiki.guildwars2.com/wiki/API) (wiki.guildwars2.com)

### API Availablility

##### Guild Example

```objc
// Get a client...
id<GW2ClientV1> client = GW2ClientV1(nil);

// Find the guild by name...
[[client fetchGuildWithName:@"New Tyrian Order"]
 subscribeNext:^(id<GW2Guild> guild) {
     NSLog(@"%@", guild);
 }];
```
```
{
    emblem =     {
        background_color_id = 146;
        background_id = 22;
        flags =         (
        );
        foreground_id = 148;
        foreground_primary_color_id = 11;
        foreground_secondary_color_id = 130;
    };
    guild_id = 6E68F577-CB39-4E1D-ADED-B7C5C39E2315;
    guild_name = New Tyrian Order;
    tag = nTo;
}
```

##### Colors Example
```
// Get a client...
id<GW2ClientV1> client = GW2ClientV1(nil);

// Take the first color we get back...
[[[client fetchColors] take:1]
         subscribeNext:^(id<GW2Color> color) {
             NSLog(@"%@", color);
         }];
```
```
{
    base_rgb =     (
        128,
        26,
        26
    );
    cloth =     {
        brightness = 45;
        contrast = 1.25;
        hue = 295;
        lightness = 1.28906;
        rgb =         (
            184,
            141,
            188
        );
        saturation = 0.351563;
    };
    leather =     {
        brightness = 42;
        contrast = 1.28906;
        hue = 295;
        lightness = 1.28906;
        rgb =         (
            171,
            132,
            175
        );
        saturation = 0.3125;
    };
    metal =     {
        brightness = 45;
        contrast = 1.64063;
        hue = 295;
        lightness = 1.48438;
        rgb =         (
            170,
            127,
            175
        );
        saturation = 0.273438;
    };
    name = Pastel Wine;
}
```
<hr/>

## Using GW2Kit

You can add the `GW2Kit` framework to your mobile and/or desktop Cocoa applications which meet these requirements:

- **OS X**: 10.9
- **iOS**: 7.0+
- **Xcode.app**: 5.0+

*Note: GW2Kit is written using the ARC (automatic reference counting) memory model.*

### Getting the code ###

#### Exploring the source ####
	
### Framework dependencies ###

`GW2Kit` relies on heavily on functional reactive programming (FRP) to perform network requests.

- [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) - functional extensions for Objective-C

### Performing tests ###

`GW2Kit`'s development is test-driven. To run tests, open `GW2Kit.xcworkspace`, and choose either `iOS Tests` or `OS X Tests`. To start, press `⌘+U`

<hr/> 

## License

Copyright 2014 Kevin Vitale

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

#### API Terms

These API’s are wholly owned by ArenaNet, LLC (“ArenaNet”). Any use of the API’s must comply with the Website Terms of Use and Content Terms of Use , however you may use the API’s to make commercial products so long as they are otherwise compliant and do not compete with ArenaNet. ArenaNet may revoke your right to use the API’s at any time. In addition, ArenaNet may create and/or amend any terms or conditions applicable to the API’s or their use at any time and from time to time. You understand and agree that ArenaNet is in the process of developing a full license agreement for these API’s and ArenaNet will publikitten when it is complete. Your continued use of the API’s constitutes acceptance of the full license agreement and any related terms or conditions when they are posted.

#### Credits

GW2Kit is brought to you by [Kevin Vitale](https://github.com/KevinVitale).
