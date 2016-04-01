#
# Be sure to run `pod lib lint Archiver.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Archiver"
  s.version          = "1.0.4"
  s.summary          = "This class will read and write objects that conform to the NSCoding protocol to disk."
  s.homepage         = "https://github.com/emailatravi/Archiver"
  s.license          = 'MIT'
  s.author           = { "Ravi Prakash Sahu" => "emailatravi@gmail.com" }
  s.source           = { :git => "https://github.com/emailatravi/Archiver.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/emailatravi'

  s.platform     = :ios, '5.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'Foundation'
end
