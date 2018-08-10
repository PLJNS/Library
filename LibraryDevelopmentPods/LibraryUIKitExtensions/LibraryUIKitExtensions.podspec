Pod::Spec.new do |spec|
    spec.name         = 'LibraryUIKitExtensions'
    spec.version      = '1.0.0'
    spec.license      = { :type => 'MIT' }
    spec.homepage     = 'pljns.com'
    spec.authors      = { 'Prolific Interactive' => 'info@prolificinteractive.com' }
    spec.summary      = 'LibraryUIKitExtensions'
    spec.source       = { :git => '', :tag => '1.0.0' }
    spec.module_name  = 'LibraryUIKitExtensions'
    spec.ios.deployment_target  = '9.0'
    spec.source_files       = 'Sources/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m'
    spec.public_header_files = 'Sources/LibraryUIKitExtensions.h'
    spec.prefix_header_file = 'Sources/LibraryUIKitExtensions-PrefixHeader.pch'
    spec.resources = 'Resources/*'
    spec.dependency 'LibrarySwiftExtensions'
end
