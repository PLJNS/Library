Pod::Spec.new do |spec|
  spec.name = 'EasyLoader'
  spec.version = '1.0.0'
  spec.authors = 'Paul Jones'
  spec.homepage = 'pljns.com'
  spec.summary = 'EasyLoader'
  spec.source = { :git => '', :tag => '1.0.0' }
  spec.module_name = 'EasyLoader'
  spec.ios.deployment_target  = '10.0'
  spec.osx.deployment_target  = '10.10'
  spec.source_files = 'Sources/**/*.swift'
  spec.public_header_files = 'Sources/EasyLoader.h'
  spec.prefix_header_file = 'Sources/EasyLoader-PrefixHeader.pch'
  spec.resources = 'Resources/*'
end
