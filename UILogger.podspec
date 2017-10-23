#
# Be sure to run `pod lib lint UILogger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UILogger'
  s.version          = '0.1.0'
  s.summary          = 'UILogger is a simple logging framework for UI actions on iOS'
  s.description      = <<-DESC
UILogger is a logging framework to log UI actions e.g. button taps, view controller appearances, table cell taps etc.
                       DESC
  s.homepage         = 'https://github.com/truemetal/ios-ui-logger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dan Pashchenko' => 'true.metal.of.steel@gmail.com' }
  s.source           = { :git => 'https://github.com/truemetal/ios-ui-logger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'UILogger/Classes/*.{h,m}'
  s.frameworks = 'UIKit'
end
