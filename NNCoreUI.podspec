#
# Be sure to run `pod lib lint NNCoreUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NNCoreUI'
  s.version          = '0.0.1'
  s.summary          = 'A short description of NNCoreUI.'
  s.homepage         = 'https://github.com/NNKit/NNCoreUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ws00801526' => '3057600441@qq.com' }
  s.source           = { :git => 'https://github.com/NNKit/NNCoreUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'NNCoreUI/Classes/**/*'
  s.dependency 'NNCore'
end
