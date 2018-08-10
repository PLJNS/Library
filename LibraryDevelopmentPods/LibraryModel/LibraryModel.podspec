Pod::Spec.new do |spec|
  spec.name         = 'LibraryModel'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://code.sephora.com/projects/CI/repos/coloriq_castapp/browse'
  spec.authors      = { 'Prolific Interactive' => 'info@prolificinteractive.com' }
  spec.summary      = 'Theme for Sephora apps.'
  spec.source       = { :git => '', :tag => '1.0.0' }
  spec.module_name  = 'LibraryModel'
  spec.ios.deployment_target  = '10.0'
  spec.osx.deployment_target  = '10.10'
  spec.source_files       = 'Sources/*'
  
  spec.public_header_files = 'Sources/LibraryModel.h'
  
  spec.prefix_header_file = 'Sources/LibraryModel-PrefixHeader.pch'

  spec.resources = 'Resources/Fonts/*.ttf', 'Resources/*.xcassets', 'Resources/Strings/*.lproj', 'Resources/*.json'

  spec.dependency 'SwiftGen'
end
