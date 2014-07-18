Pod::Spec.new do |s|
  s.name         			= "Archiver"
  s.version      			= "1.0.0"
  s.summary      			= "Simple classes to make object persistence with NSCoding easier. Category based on NSObject+NSCoding"
  s.license      			= "GNU General Public License"
  s.author       			= { "Ravi Prakash Sahu" => "emailatravi@gmail.com" }
  s.ios.deployment_target 	= "4.0"
  s.source       			= { :git => "https://github.com/emailatravi/Archiver.git", :tag => "1.0.0" }
  s.source_files  			= "Archiver", "Vendor/**/*.{h,m}"

  s.public_header_files 	= "Vendor/**/*.h"

end