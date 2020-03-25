#
# Be sure to run `pod lib lint FFSwiftExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FFSwiftExtension'
  s.version          = '0.0.1'
  s.summary          = '这是一个总结性的FFSwiftExtension.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '构建初衷，希望可以不断总结一些扩展，便于开发'

  s.homepage         = 'https://github.com/cocoanerd/FFSwiftExtension.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cocoanerd' => 'cocoanerd@163.com' }
  s.source           = { :git => 'https://github.com/cocoanerd/FFSwiftExtension.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'
  
  
  s.subspec 'UIKit' do |ss|
      ss.source_files = 'FFSwiftExtension/UI{Application,Button,Color,Label,Pasteboard,Screen,View,ViewController}+Ex.swift'
  end
  
  s.subspec 'Foundation' do |ss|
      ss.source_files = 'FFSwiftExtension/{String,AttributedString,CGFloat,Double,Int}+Ex.swift', 'FFSwiftExtension/UserDefaults.swift'
  end
  # s.resource_bundles = {
  #   'FFSwiftExtension' => ['FFSwiftExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
