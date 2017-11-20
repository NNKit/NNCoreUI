#
# Be sure to run `pod lib lint NNCoreUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NNCoreUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NNCoreUI.'
  s.homepage         = 'https://github.com/ws00801526/NNCoreUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ws00801526' => '3057600441@qq.com' }
  s.source           = { :git => 'https://github.com/ws00801526/NNCoreUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'NNCoreUI/Classes/**/*'
  s.dependency 'NNCore'
  # s.resource_bundles = {
  #   'NNCoreUI' => ['NNCoreUI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
