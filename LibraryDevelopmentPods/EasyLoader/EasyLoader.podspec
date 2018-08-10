Pod::Spec.new do |spec|
    spec.name         = 'EasyLoader'
    spec.version      = '1.0.0'
    spec.license      = { :type => 'MIT' }
    spec.homepage     = 'pljns.com'
    spec.authors      = { 'Prolific Interactive' => 'info@prolificinteractive.com' }
    spec.summary      = 'EasyLoader'
    spec.source       = { :git => '', :tag => '1.0.0' }
    spec.module_name  = 'EasyLoader'
    spec.source_files       = 'Sources/*.swift', 'Sources/**/*.m', 'Sources/**/*.h', 'Sources/*.h', 'Sources/*.m'
    spec.public_header_files = 'Sources/EasyLoader.h'
    spec.prefix_header_file = 'Sources/EasyLoader-PrefixHeader.pch'
    spec.resources = 'Resources/*'
end
