Pod::Spec.new do |spec|
  spec.name = 'LibraryDebug'
  spec.version = '1.0.0'
  spec.authors = 'Paul Jones'
  spec.homepage = 'pljns.com'
  spec.summary = 'LibraryDebug'
  spec.source = { :git => '', :tag => '1.0.0' }
  spec.module_name = 'LibraryDebug'
  spec.ios.deployment_target = '10.0'
  spec.source_files = 'Sources/**/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m', 'Sources/*.swift'
  spec.public_header_files = 'Sources/LibraryDebug.h'
  spec.prefix_header_file = 'Sources/LibraryDebug-PrefixHeader.pch'
  spec.resources = 'Resources/*'
  spec.dependency 'LibrarySwiftExtensions'
  spec.dependency 'LibraryService'
  spec.dependency 'LibraryModel'
end
