Pod::Spec.new do |spec|
  spec.name = 'LibraryService'
  spec.version = '1.0.0'
  spec.authors = 'Paul Jones'
  spec.homepage = 'pljns.com'
  spec.summary = 'LibraryService'
  spec.source = { :git => '', :tag => '1.0.0' }
  spec.module_name = 'LibraryService'
  spec.ios.deployment_target = '10.0'
  spec.source_files = 'Sources/**/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m', 'Sources/*.swift'
  spec.public_header_files = 'Sources/LibraryService.h'
  spec.prefix_header_file = 'Sources/LibraryService-PrefixHeader.pch'
  spec.resources = 'Resources/*'
  spec.dependency 'CodableClient'
end
