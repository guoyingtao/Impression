#
# Be sure to run `pod lib lint Impression.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Impression'
  s.version          = '1.1.3'
  s.summary          = 'A swift photo filter'
  s.swift_version    = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Impression is a swift photo filter tool which is easy for users to add their filters.
                       DESC

  s.homepage         = 'https://github.com/guoyingtao/Impression'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'starecho' => 'guoyingtao@outlook.com' }
  s.source           = { :git => 'https://github.com/guoyingtao/Impression.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/guoyingtao'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Impression/**/*.{h,swift}'
  
  # s.resource_bundles = {
  #   'Impression' => ['Impression/Assets/*.png']
  # }
end
