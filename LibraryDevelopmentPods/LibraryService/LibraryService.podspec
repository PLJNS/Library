Pod::Spec.new do |spec|
  spec.name = 'Template'
  spec.version = '1.0.0'
  spec.authors = 'Paul Jones'
  spec.homepage = 'pljns.com'
  spec.summary = 'Template'
  spec.source = { :git => '', :tag => '1.0.0' }
  spec.module_name = 'Template'
  spec.ios.deployment_target  = '10.0'
  spec.osx.deployment_target  = '10.10'
  spec.source_files = 'Sources/**/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m', 'Sources/*.swift'
  spec.public_header_files = 'Sources/Template.h'
  spec.prefix_header_file = 'Sources/Template-PrefixHeader.pch'
  spec.resources = 'Resources/*'
  spec.dependency 'CodableClient'
  spec.dependency 'LibraryModel'
end
