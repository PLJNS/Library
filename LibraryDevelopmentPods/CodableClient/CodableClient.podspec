Pod::Spec.new do |spec|
  spec.name = 'CodableClient'
  spec.version = '1.0.0'
  spec.authors = 'Paul Jones'
  spec.homepage = 'pljns.com'
  spec.summary = 'CodableClient'
  spec.source = { :git => '', :tag => '1.0.0' }
  spec.module_name = 'CodableClient'
  spec.ios.deployment_target = '10.0'
  spec.source_files = 'Sources/**/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m', 'Sources/*.swift'
  spec.public_header_files = 'Sources/CodableClient.h'
  spec.prefix_header_file = 'Sources/CodableClient-PrefixHeader.pch'
  spec.resources = 'Resources/*'
end
