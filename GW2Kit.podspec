Pod::Spec.new do |s|
  s.name         = "GW2Kit"
  s.version      = "0.0.1"
  s.summary      = "iOS & OS X framework for Guild Wars 2 API"
  s.homepage     = "https://github.com/KevinVitale/GW2Kit"
  s.license      = 'Apache 2.0'
  s.author       = { "Kevin Vitale" => "kevinvitale@gmail.com" }
  s.source       = { :git => "https://github.com/KevinVitale/GW2Kit.git" }
  s.social_media_url = "http://twitter.com/vitalekj"

  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  s.dependency 'ReactiveCocoa', '~> 2.2.4'
  s.dependency 'Mantle', '~> 1.3.1'

  s.subspec 'Categories' do |cats|
      cats.source_files = 'GW2Kit/Categories/*.{h,m}'
  end
  
  s.subspec 'Core' do |c|
    c.source_files = 'GW2Kit/Core/GW2{Client,Object*}.{h,m}'
    c.private_header_files = 'GW2Kit/Core/*+Private.h'

    c.subspec 'Maps' do |maps|
      maps.source_files = 'GW2Kit/Core/Maps/GW2{EventLocation,*Map*}.{h,m}'
    end

    c.subspec 'Events' do |events|
      events.source_files = 'GW2Kit/Core/Events/GW2Event*.{h,m}'
    end

    c.subspec 'Guild' do |guilds|
      guilds.source_files = 'GW2Kit/Core/Guild/GW2Guild.{h,m}'
    end

    c.subspec 'WvW' do |wvw|
      wvw.source_files = 'GW2Kit/Core/WvW/GW2WvW*.{h,m}'
    end

    c.subspec 'Misc' do |misc|
      misc.source_files = 'GW2Kit/Core/Misc/GW2Color.{h,m}'
    end
  end
end
