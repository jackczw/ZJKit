#
# Be sure to run `pod lib lint zhujian.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'zhujian'
  s.version          = '1'
  s.summary          = '这是一个断的描述'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 这是一个很长的详细描述这是一个很长的详细描述这是一个很长的详细描述这是一个很长的详细描述这是一个很长的详细描述这是一个很长的详细描述这是一个很长的详细描述.
                       DESC

  s.homepage         = 'https://github.com/jackczw/ZJKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jackczw' => '1565201275@qq.com' }
  s.source           = { :git => 'https://github.com/jackczw/ZJKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'zhujian/Classes/**/*'
  
  # s.resource_bundles = {
  #   'zhujian' => ['zhujian/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
