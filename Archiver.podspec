Pod::Spec.new do |s|
  s.name         			= 'Archiver'
  s.version      			= '1.0.0'
  s.summary      			= 'Simple classes to make object persistence with NSCoding
   easier. Category based on NSObject+NSCoding'
  s.homepage 				= 'https://github.com/emailatravi/Archiver'
  s.license      			= {
      :type => 'GNU General Public License'
      :file => 'LICENSE'
  }
  s.author       			= {
      'Ravi Prakash Sahu' => 'emailatravi@gmail.com'
  }
  s.ios.deployment_target 	= '4.0'
  s.source       			= {
      :git => 'https://github.com/emailatravi/Archiver.git',
      :commit => 'ec576bfc46015105c06e70655a42723602d60635'
  }
  s.source_files  			= 'Vendor/**/*.{h,m}'
  s.requires_arc 			= false
  s.public_header_files 	= 'Vendor/**/*.h'

end
