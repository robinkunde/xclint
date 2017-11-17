Pod::Spec.new do |s|
  s.name             = "xclint"
  s.version          = "0.1.0"
  s.summary          = "Lint your Xcode projects"
  s.homepage         = "https://github.com/xcodeswift/xclint"
  s.social_media_url = 'https://twitter.com/xcodeswiftio'
  s.license          = 'MIT'
  s.author           = "Pedro Piñera"
  s.source           = { :git => "https://github.com/xcodeswift/xclint.git", :tag => s.version.to_s }
  s.requires_arc = true

  s.osx.deployment_target = '10.10'
  s.ios.deployment_target = '8.0'

  s.source         = { :http => "https://github.com/xcodeswift/xclint/releases/download/#{s.version}/xclint.tar.gz" }
  s.preserve_paths = '*'
  s.exclude_files  = '**/xclint.tar.gz'

end
