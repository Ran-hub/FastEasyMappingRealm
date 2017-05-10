Pod::Spec.new do |spec|
  spec.name         = 'FastEasyMappingRealm'
  spec.version      = '1.0'
  spec.summary      = 'Fast mapping from JSON to Realm'
  spec.homepage     = "https://github.com/Yalantis/FastEasyMappingRealm"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { 'Dima Zen' => 'zen.dev@yandex.com' }
  spec.source       = { :git => 'https://github.com/Yalantis/FastEasyMappingRealm.git', :tag => spec.version }

  spec.ios.deployment_target = '8.0'
  spec.osx.deployment_target = '10.9'
  spec.tvos.deployment_target = '9.0'
  spec.watchos.deployment_target = '2.0'

  spec.requires_arc = true

  spec.dependency 'FastEasyMapping', '~> 1.2'
  spec.dependency 'Realm', '~> 2.7'

  spec.source_files = 'FastEasyMappingRealm/**/*.{h,m}'
  spec.private_header_files = 'FastEasyMappingRealm/Private/**/*.{h}'
end
