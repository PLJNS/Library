Pod::Spec.new do |spec|
  spec.name = 'LibraryClient'
  spec.version = '1.0.0'
  spec.authors = 'Paul Jones'
  spec.homepage = 'pljns.com'
  spec.summary = 'LibraryClient'
  spec.source = { :git => '', :tag => '1.0.0' }
  spec.module_name = 'LibraryClient'
  spec.ios.deployment_target = '10.0'
  spec.source_files = 'Sources/**/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m', 'Sources/*.swift'
  spec.public_header_files = 'Sources/LibraryClient.h'
  spec.prefix_header_file = 'Sources/LibraryClient-PrefixHeader.pch'
  spec.resources = 'Resources/*'
  spec.dependency 'LibraryExtensions'
end
