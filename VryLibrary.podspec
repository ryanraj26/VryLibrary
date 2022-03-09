#
# Be sure to run `pod lib lint VryLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VryLibrary'
  s.version          = '0.1.0'
  s.summary          = 'VryLibrary is a UI component library'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  'VryLibrary is a UI component library for Veryable'
                       DESC

  s.homepage         = 'https://github.com/ryanraj26/VryLibrary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ryanraj26' => 'ryan.raj27@outlook.com' }
  s.source           = { :git => 'https://github.com/ryanraj26/VryLibrary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Source/**/*.swift'
  
  s.swift_version = '5.2'
  
  # s.resource_bundles = {
  #   'VryLibrary' => ['VryLibrary/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'SnapKit', '~> 5.0.1'
end
