# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'spotify' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for spotify
  pod 'SnapKit', '~> 5.0.0'
  pod 'Moya', '~> 15.0'
  pod 'Kingfisher', '~> 7.0'
  pod 'SwiftKeychainWrapper'
  pod 'SkeletonView'

 post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end

end
