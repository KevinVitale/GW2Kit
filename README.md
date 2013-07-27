# GW2Kit

GW2Kit is a Objective-C framework that provides access to the offical Guild Wars 2 API (`api.guildwars2.com`). It is has support for both iOS and OS X.

### Introduction

The Official Guild Wars 2 API was released on May 20th, posted by ArenaNet Lead Programmer [Cliff Spradlin](https://forum-en.guildwars2.com/forum/community/api/API-Documentation/first#post2028044). It provides third-party application the ability to query in-game data in real-time. 

- [The API documentation](https://forum-en.guildwars2.com/forum/community/api/API-Documentation/first#post2028044) (Guild Wars 2 Forums)
- [Guild Wars 2 API wiki page](http://wiki.guildwars2.com/wiki/API) (wiki.guildwars2.com)

### API Availablility

GW2Kit provides functionality through separate *daemons*, each implemented as a subclass of [`GW2DefaultDaemon`](https://github.com/KevinVitale/GW2Kit/blob/master/GW2Kit/Core/GW2DefaultDaemon.h) in code. GW2Kit's core daemons are:

- **Events**
    - Names of events, maps, and PvE worlds.
    - Event statuses and details.
- **Items**
    - Item IDs and names.
    - Recipe IDs and details.
- **WvW**
    - Currently running matches
    - Details of a given match ID
    - Names of objectives in WvW
    - Match statuses and world rankings from *[gw2stats.net](http://gw2stats.net)*
- **Guilds**
    - Guild details
- **Stats**
    - API status from *[gw2stats.net](http://gw2stats.net)*
- **Spidy**
    - Trading post prices from *[gw2spidy.com](http://www.gw2spidy.com)*
- **Misc**
    - In-game dye colors
    - API build version

<hr/>

## Using GW2Kit

You can add the `GW2Kit` framework to your mobile and/or desktop Cocoa applications which meet these requirements:

- **OS X**: 10.7+
- **iOS**: 5.0+
- **Xcode.app**: 4.6+

*Note: GW2Kit is written using the ARC (automatic reference counting) memory model.*

### Getting the code ###

#### Exploring the source

If you want to explore the GW2Kit project and try out the test apps, do the following:

Open your **Terminal.app**  
  *Located: /Applications/Utilities/Terminal.app*

	$ cd /path/to/some_directory
	$ git clone git://github.com/KevinVitale/GW2Kit.git
	$ cd GW2Kit
	$ git submodule update --init --recursive
	$ open GW2KitTests/GW2KitTests/GW2KitTests.xcodeproj/
	
#### Adding GW2Kit to a new or existing app

If all you want is to add GW2Kit to a new or existing project, you can do the following:

##### For iOS apps:

1. Open Xcode and start a new iOS project (skip if you already have a project)  
    - *Select the project template you prefer (I usually prefer 'Empty Application' project)*
- From outside Xcode, follow the instructions above to clone the project into a `GW2Kit` folder inside your project's root directory  
    - *Really make sure you've updated GW2Kit's submodules*
- Back in Xcode, Drag the `GW2Kit.xcodeproj` file into your app's project navigation
- Select your project's target's own build settings, and then click on "Build Settings"
- Set *Header Search Paths* to be (including quotes):  
    - *"$(BUILT_PRODUCTS_DIR)/../../Headers"*  
    - *"$(BUILT_PRODUCTS_DIR)"*  
- Set *Other Linker Flags* to be:  
    - *-ObjC*  
- Now for the other build settings, click on "Build Phases"  
- In "Link Binary With Libraries" section, add the following libraries:  
    - *libGW2Kit-iOS.a*  
    - *CoreData.framework*  
    - *Security.framework*  
    - *SystemConfiguration.framework*  
    - *MobileCoreServices.framework*  
- (Optional) To get rid of the warnings from AFNetworking, change your app's .pch file to look like this:

		#import <Availability.h>

		#ifndef __IPHONE_3_0
		#warning "This project uses features only available in iOS SDK 3.0 and later."
		#endif

		#ifdef __OBJC__
		    #import <UIKit/UIKit.h>
		    #import <Foundation/Foundation.h>
		    #import <SystemConfiguration/SystemConfiguration.h>
		    #import <MobileCoreServices/MobileCoreServices.h>
		#endif
- Finally, make sure it works:  
    - Add `#import <GW2Kit/GW2Kit.h>` to your app delegate's `.m` (implementation) file
- Start coding!
	
### Framework dependencies

You might notice that there are a lot of schemes in Xcode's scheme list. This will be fixed soon, but part of the reason is that `GW2Kit` relies on two other frameworks:

- [RestKit](https://github.com/RestKit/RestKit) - network communication and parsing
- [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) - functional extensions for Objective-C

### Running the iOS example

In Xcode's scheme picker, select **GW2KitTestiOSApp** Build & Run the app by pressing the giant play button or hitting **⌘+R**.

<hr/> 

## License

Copyright 2013 Kevin Vitale

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
