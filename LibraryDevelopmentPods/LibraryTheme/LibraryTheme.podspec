Pod::Spec.new do |spec|
    spec.name         = 'LibraryTheme'
    spec.version      = '1.0.0'
    spec.license      = { :type => 'MIT' }
    spec.homepage     = 'pljns.com'
    spec.authors      = { 'Prolific Interactive' => 'info@prolificinteractive.com' }
    spec.summary      = 'LibraryTheme'
    spec.source       = { :git => '', :tag => '1.0.0' }
    spec.module_name  = 'LibraryTheme'
    spec.ios.deployment_target  = '10.0'
    spec.source_files       = 'Sources/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m'
    spec.public_header_files = 'Sources/LibraryTheme.h'
    spec.prefix_header_file = 'Sources/LibraryTheme-PrefixHeader.pch'
    spec.resources = 'Resources/*'
    spec.dependency 'LibraryResources'
end
