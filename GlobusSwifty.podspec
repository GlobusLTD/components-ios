Pod::Spec.new do |s|
  s.name = 'GlobusSwifty'
  s.version = '0.4.7'
  s.homepage = 'http://www.globus-ltd.com'
  s.summary = 'Globus components for iOS'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = {
    'Alexander Trifonov' => 'a.trifonov@globus-ltd.com'
  }
  s.source = {
    :git => 'https://github.com/GlobusLTD/components-ios.git',
    :tag => s.version.to_s
  }
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true

  s.subspec 'ApiManager' do |ss|
    ss.source_files = 'GlobusSwifty/ApiManager/**/*.{swift}'
    ss.dependency 'Globus/ApiManager'
  end
  s.subspec 'StructedObject' do |ss|
    ss.source_files = 'GlobusSwifty/StructedObject/**/*.{swift}'
    ss.dependency 'Globus/StructedObject'
  end
  s.subspec 'Json' do |ss|
    ss.source_files = 'GlobusSwifty/Json/**/*.{swift}'
    ss.dependency 'GlobusSwifty/StructedObject'
    ss.dependency 'Globus/Json'
  end
  s.subspec 'Pack' do |ss|
    ss.source_files = 'GlobusSwifty/Pack/**/*.{swift}'
    ss.dependency 'GlobusSwifty/StructedObject'
    ss.dependency 'Globus/Pack'
  end
  s.subspec 'Model' do |ss|
    ss.source_files = 'GlobusSwifty/Model/**/*.{swift}'
    ss.dependency 'Globus/CoreFoundation/FileManager'
    ss.dependency 'GlobusSwifty/Json'
    ss.dependency 'GlobusSwifty/Pack'
  end
end
