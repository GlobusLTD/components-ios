Pod::Spec.new do |s|
  s.name = 'Globus'
  s.version = '0.2.14'
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
  s.ios.deployment_target = '7.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true

  s.subspec 'CocoaPods' do |ss|
    ss.source_files = 'Globus/CocoaPods/**/*.{h,m}'
  end
  s.subspec 'CoreFoundation' do |ss|
    ss.subspec 'Base' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Base/**/*.{h,m}'
      sss.ios.frameworks = 'Foundation'
      sss.watchos.frameworks = 'Foundation'
    end
    ss.subspec 'Debug' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Debug/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/PointerArray'
      sss.dependency 'Globus/CoreFoundation/String'
      sss.dependency 'Globus/CoreFoundation/Data'
    end
    ss.subspec 'Pack' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Pack/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Stream'
    end
    ss.subspec 'Array' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Array/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'AttributedString' do |sss|
      sss.source_files = 'Globus/CoreFoundation/AttributedString/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Bundle' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Bundle/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Data' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Data/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Date' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Date/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'DateFormatter' do |sss|
      sss.source_files = 'Globus/CoreFoundation/DateFormatter/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Dictionary' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Dictionary/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/String'
    end
    ss.subspec 'Error' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Error/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'FileManager' do |sss|
      sss.source_files = 'Globus/CoreFoundation/FileManager/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'HTTPCookieStorage' do |sss|
      sss.source_files = 'Globus/CoreFoundation/HTTPCookieStorage/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Null' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Null/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Number' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Number/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'OrderedSet' do |sss|
      sss.source_files = 'Globus/CoreFoundation/OrderedSet/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'PointerArray' do |sss|
      sss.source_files = 'Globus/CoreFoundation/PointerArray/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Set' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Set/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Stream' do |sss|
      sss.source_files = 'Globus/CoreFoundation/Stream/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'String' do |sss|
      sss.source_files = 'Globus/CoreFoundation/String/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'URL' do |sss|
      sss.source_files = 'Globus/CoreFoundation/URL/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/String'
    end
  end
  s.subspec 'CoreGraphics' do |ss|
    ss.source_files = 'Globus/CoreGraphics/**/*.{h,m}'
    ss.ios.frameworks = 'CoreGraphics'
    ss.ios.frameworks = 'QuartzCore'
    ss.watchos.frameworks = 'CoreGraphics'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'CoreAnimation' do |ss|
    ss.source_files = 'Globus/CoreAnimation/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'UIKit' do |ss|
    ss.subspec 'Base' do |sss|
      sss.source_files = 'Globus/UIKit/Base/**/*.{h,m}'
      sss.ios.frameworks = 'UIKit'
      sss.watchos.frameworks = 'UIKit'
      sss.dependency 'Globus/CoreFoundation/Base'
    end
    ss.subspec 'Application' do |sss|
      sss.source_files = 'Globus/UIKit/Application/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Base'
    end
    ss.subspec 'Button' do |sss|
      sss.source_files = 'Globus/UIKit/Button/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/View'
    end
    ss.subspec 'Color' do |sss|
      sss.source_files = 'Globus/UIKit/Color/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Base'
    end
    ss.subspec 'Device' do |sss|
      sss.source_files = 'Globus/UIKit/Device/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Base'
    end
    ss.subspec 'GestureRecognizer' do |sss|
      sss.source_files = 'Globus/UIKit/GestureRecognizer/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Base'
    end
    ss.subspec 'Image' do |sss|
      sss.source_files = 'Globus/UIKit/Image/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Base'
      sss.dependency 'Globus/CoreGraphics'
    end
    ss.subspec 'Label' do |sss|
      sss.source_files = 'Globus/UIKit/Label/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Base'
    end
    ss.subspec 'NavigationController' do |sss|
      sss.source_files = 'Globus/UIKit/NavigationController/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Array'
      sss.dependency 'Globus/UIKit/ViewController'
      sss.dependency 'Globus/UIKit/Button'
    end
    ss.subspec 'Nib' do |sss|
      sss.source_files = 'Globus/UIKit/Nib/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Device'
    end
    ss.subspec 'Responder' do |sss|
      sss.source_files = 'Globus/UIKit/Responder/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/View'
    end
    ss.subspec 'ScrollView' do |sss|
      sss.source_files = 'Globus/UIKit/ScrollView/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Responder'
    end
    ss.subspec 'TabBar' do |sss|
      sss.source_files = 'Globus/UIKit/TabBar/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/View'
    end
    ss.subspec 'View' do |sss|
      sss.source_files = 'Globus/UIKit/View/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Base'
    end
    ss.subspec 'ViewController' do |sss|
      sss.source_files = 'Globus/UIKit/ViewController/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/View'
      sss.dependency 'Globus/UIKit/Nib'
    end
    ss.subspec 'Window' do |sss|
      sss.source_files = 'Globus/UIKit/Window/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/ViewController'
    end
  end
  s.subspec 'Grid' do |ss|
    ss.source_files = 'Globus/Grid/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'Action' do |ss|
    ss.source_files = 'Globus/Action/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Debug'
    ss.dependency 'Globus/CoreFoundation/Dictionary'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/CoreFoundation/String'
  end
  s.subspec 'Timer' do |ss|
    ss.source_files = 'Globus/Timer/**/*.{h,m}'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'Timeout' do |ss|
    ss.source_files = 'Globus/Timeout/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'Observer' do |ss|
    ss.source_files = 'Globus/Observer/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Debug'
    ss.dependency 'Globus/CoreFoundation/PointerArray'
    ss.dependency 'Globus/CoreFoundation/String'
  end
  s.subspec 'KVO' do |ss|
    ss.source_files = 'Globus/KVO/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'RegExpParser' do |ss|
    ss.source_files = 'Globus/RegExpParser/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'TaskManager' do |ss|
    ss.source_files = 'Globus/TaskManager/**/*.{h,m}'
    ss.ios.frameworks = 'UIKit'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'Model' do |ss|
    ss.source_files = 'Globus/Model/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Debug'
    ss.dependency 'Globus/CoreFoundation/Pack'
    ss.dependency 'Globus/CoreFoundation/Dictionary'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/CoreFoundation/PointerArray'
    ss.dependency 'Globus/CoreFoundation/String'
    ss.dependency 'Globus/CoreFoundation/Date'
    ss.dependency 'Globus/CoreFoundation/FileManager'
    ss.dependency 'Globus/CoreFoundation/Bundle'
    ss.dependency 'Globus/UIKit/Device'
    ss.dependency 'Globus/UIKit/Color'
  end
  s.subspec 'ManagedModel' do |ss|
    ss.source_files = 'Globus/ManagedModel/**/*.{h,m}'
    ss.ios.frameworks = 'CoreData'
    ss.watchos.frameworks = 'CoreData'
    ss.dependency 'Globus/Model'
  end
  s.subspec 'Cache' do |ss|
    ss.source_files = 'Globus/Cache/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/String'
    ss.dependency 'Globus/CoreFoundation/Date'
    ss.dependency 'Globus/CoreFoundation/FileManager'
  end
  s.subspec 'ApiManager' do |ss|
    ss.source_files = 'Globus/ApiManager/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Debug'
    ss.dependency 'Globus/CoreFoundation/Dictionary'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/CoreFoundation/OrderedSet'
    ss.dependency 'Globus/CoreFoundation/Set'
    ss.dependency 'Globus/CoreFoundation/String'
    ss.dependency 'Globus/CoreFoundation/Date'
    ss.dependency 'Globus/CoreFoundation/Data'
    ss.dependency 'Globus/CoreFoundation/URL'
    ss.dependency 'Globus/CoreFoundation/Error'
  end
  s.subspec 'DataSource' do |ss|
    ss.source_files = 'Globus/DataSource/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'SpinnerView' do |ss|
    ss.subspec 'Base' do |sss|
      sss.source_files = 'Globus/SpinnerView/Base/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/View'
    end
    ss.subspec 'Arc' do |sss|
      sss.source_files = 'Globus/SpinnerView/Arc/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'ArcAlt' do |sss|
      sss.source_files = 'Globus/SpinnerView/ArcAlt/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'Bounce' do |sss|
      sss.source_files = 'Globus/SpinnerView/Bounce/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'ChasingDots' do |sss|
      sss.source_files = 'Globus/SpinnerView/ChasingDots/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'Circle' do |sss|
      sss.source_files = 'Globus/SpinnerView/Circle/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'CircleFlip' do |sss|
      sss.source_files = 'Globus/SpinnerView/CircleFlip/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
      sss.dependency 'Globus/CoreAnimation'
    end
    ss.subspec 'FadingCircle' do |sss|
      sss.source_files = 'Globus/SpinnerView/FadingCircle/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'FadingCircleAlt' do |sss|
      sss.source_files = 'Globus/SpinnerView/FadingCircleAlt/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'NineCubeGrid' do |sss|
      sss.source_files = 'Globus/SpinnerView/NineCubeGrid/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'Plane' do |sss|
      sss.source_files = 'Globus/SpinnerView/Plane/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
      sss.dependency 'Globus/CoreAnimation'
    end
    ss.subspec 'Pulse' do |sss|
      sss.source_files = 'Globus/SpinnerView/Pulse/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'ThreeBounce' do |sss|
      sss.source_files = 'Globus/SpinnerView/ThreeBounce/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'WanderingCubes' do |sss|
      sss.source_files = 'Globus/SpinnerView/WanderingCubes/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'Wave' do |sss|
      sss.source_files = 'Globus/SpinnerView/Wave/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
    ss.subspec 'WordPress' do |sss|
      sss.source_files = 'Globus/SpinnerView/WordPress/**/*.{h,m}'
      sss.dependency 'Globus/SpinnerView/Base'
    end
  end
  s.subspec 'BlurView' do |ss|
    ss.source_files = 'Globus/BlurView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/View'
    ss.dependency 'Globus/UIKit/Image'
  end
  s.subspec 'ActivityView' do |ss|
    ss.source_files = 'Globus/ActivityView/**/*.{h,m}'
    ss.dependency 'Globus/SpinnerView/Base'
    ss.dependency 'Globus/UIKit/View'
    ss.dependency 'Globus/UIKit/Label'
    ss.dependency 'Globus/CoreGraphics'
  end
  s.subspec 'InputValidation' do |ss|
    ss.source_files = 'Globus/InputValidation/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/CoreFoundation/String'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'TextField' do |ss|
    ss.source_files = 'Globus/TextField/**/*.{h,m}'
    ss.dependency 'Globus/InputValidation'
    ss.dependency 'Globus/UIKit/Responder'
    ss.dependency 'Globus/UIKit/View'
  end
  s.subspec 'DateField' do |ss|
    ss.source_files = 'Globus/DateField/**/*.{h,m}'
    ss.dependency 'Globus/TextField'
  end
  s.subspec 'ListField' do |ss|
    ss.source_files = 'Globus/ListField/**/*.{h,m}'
    ss.dependency 'Globus/TextField'
  end
  s.subspec 'PhoneField' do |ss|
    ss.source_files = 'Globus/PhoneField/**/*.{h,m}'
    ss.dependency 'Globus/TextField'
  end
  s.subspec 'TextView' do |ss|
    ss.source_files = 'Globus/TextView/**/*.{h,m}'
    ss.dependency 'Globus/InputValidation'
    ss.dependency 'Globus/UIKit/Responder'
    ss.dependency 'Globus/UIKit/View'
  end
  s.subspec 'BadgeView' do |ss|
    ss.source_files = 'Globus/BadgeView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/View'
  end
  s.subspec 'Button' do |ss|
    ss.source_files = 'Globus/Button/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/Button'
    ss.dependency 'Globus/UIKit/Color'
  end
  s.subspec 'LayoutView' do |ss|
    ss.source_files = 'Globus/LayoutView/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/UIKit/View'
    ss.dependency 'Globus/KVO'
  end
  s.subspec 'LoadedView' do |ss|
    ss.source_files = 'Globus/LoadedView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/View'
    ss.dependency 'Globus/UIKit/Nib'
  end
  s.subspec 'PageControl' do |ss|
    ss.source_files = 'Globus/PageControl/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/View'
  end
  s.subspec 'RoundView' do |ss|
    ss.source_files = 'Globus/RoundView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/View'
  end
  s.subspec 'TouchView' do |ss|
    ss.source_files = 'Globus/TouchView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/View'
  end
  s.subspec 'ImageView' do |ss|
    ss.source_files = 'Globus/ImageView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/View'
    ss.dependency 'Globus/UIKit/Image'
    ss.dependency 'Globus/UIKit/Color'
    ss.dependency 'Globus/ApiManager'
    ss.dependency 'Globus/Cache'
  end
  s.subspec 'ScrollView' do |ss|
    ss.source_files = 'Globus/ScrollView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/ScrollView'
  end
  s.subspec 'SearchBar' do |ss|
    ss.source_files = 'Globus/SearchBar/**/*.{h,m}'
    ss.dependency 'Globus/TextField'
    ss.dependency 'Globus/Button'
  end
  s.subspec 'DataView' do |ss|
    ss.subspec 'Base' do |sss|
      sss.source_files = 'Globus/DataView/Base/**/*.{h,m}'
      sss.dependency 'Globus/CoreFoundation/Dictionary'
      sss.dependency 'Globus/CoreFoundation/Array'
      sss.dependency 'Globus/UIKit/ScrollView'
      sss.dependency 'Globus/UIKit/GestureRecognizer'
      sss.dependency 'Globus/UIKit/Nib'
      sss.dependency 'Globus/UIKit/Device'
      sss.dependency 'Globus/CoreGraphics'
      sss.dependency 'Globus/Window'
      sss.dependency 'Globus/SearchBar'
      sss.dependency 'Globus/Action'
      sss.dependency 'Globus/Timeout'
    end
    ss.subspec 'SwipeCell' do |sss|
      sss.source_files = 'Globus/DataView/Cells/Swipe/**/*.{h,m}'
      sss.dependency 'Globus/DataView/Base'
    end
    ss.subspec 'SectionsListContainer' do |sss|
      sss.source_files = 'Globus/DataView/Containers/SectionsList/**/*.{h,m}'
      sss.dependency 'Globus/DataView/Base'
    end
    ss.subspec 'ItemsListContainer' do |sss|
      sss.source_files = 'Globus/DataView/Containers/ItemsList/**/*.{h,m}'
      sss.dependency 'Globus/DataView/Base'
    end
    ss.subspec 'ItemsFlowContainer' do |sss|
      sss.source_files = 'Globus/DataView/Containers/ItemsFlow/**/*.{h,m}'
      sss.dependency 'Globus/DataView/Base'
    end
  end
  s.subspec 'PressAndHoldGestureRecognizer' do |ss|
    ss.source_files = 'Globus/PressAndHoldGestureRecognizer/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/Base'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'Window' do |ss|
    ss.source_files = 'Globus/Window/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/Responder'
    ss.dependency 'Globus/UIKit/Application'
    ss.dependency 'Globus/UIKit/Window'
  end
  s.subspec 'TransitionController' do |ss|
    ss.subspec 'Base' do |sss|
      sss.source_files = 'Globus/TransitionController/Base/**/*.{h,m}'
      sss.dependency 'Globus/UIKit/Device'
    end
    ss.subspec 'Cards' do |sss|
      sss.source_files = 'Globus/TransitionController/Cards/**/*.{h,m}'
      sss.dependency 'Globus/TransitionController/Base'
    end
    ss.subspec 'CrossFade' do |sss|
      sss.source_files = 'Globus/TransitionController/CrossFade/**/*.{h,m}'
      sss.dependency 'Globus/TransitionController/Base'
    end
    ss.subspec 'Material' do |sss|
      sss.source_files = 'Globus/TransitionController/Material/**/*.{h,m}'
      sss.dependency 'Globus/TransitionController/Base'
      sss.dependency 'Globus/UIKit/View'
    end
    ss.subspec 'Slide' do |sss|
      sss.source_files = 'Globus/TransitionController/Slide/**/*.{h,m}'
      sss.dependency 'Globus/TransitionController/Base'
      sss.dependency 'Globus/CoreGraphics'
    end
  end
  s.subspec 'BaseViewController' do |ss|
    ss.source_files = 'Globus/BaseViewController/**/*.{h,m}'
    ss.dependency 'Globus/TransitionController/Base'
    ss.dependency 'Globus/Window'
    ss.dependency 'Globus/CoreFoundation/String'
    ss.dependency 'Globus/UIKit/ViewController'
    ss.dependency 'Globus/UIKit/Device'
  end
  s.subspec 'DialogViewController' do |ss|
    ss.source_files = 'Globus/DialogViewController/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/Application'
    ss.dependency 'Globus/UIKit/ViewController'
    ss.dependency 'Globus/UIKit/Window'
  end
  s.subspec 'SlideViewController' do |ss|
    ss.source_files = 'Globus/SlideViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/CoreGraphics'
    ss.dependency 'Globus/UIKit/Application'
    ss.dependency 'Globus/UIKit/Device'
  end
  s.subspec 'PageViewController' do |ss|
    ss.source_files = 'Globus/PageViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/UIKit/ScrollView'
  end
  s.subspec 'NavigationViewController' do |ss|
    ss.source_files = 'Globus/NavigationViewController/**/*.{h,m}'
    ss.dependency 'Globus/TransitionController/Base'
    ss.dependency 'Globus/UIKit/NavigationController'
    ss.dependency 'Globus/UIKit/Device'
  end
  s.subspec 'TabBarViewController' do |ss|
    ss.source_files = 'Globus/TabBarViewController/**/*.{h,m}'
    ss.dependency 'Globus/TransitionController/Base'
    ss.dependency 'Globus/UIKit/ViewController'
    ss.dependency 'Globus/UIKit/Device'
  end
  s.subspec 'SplitViewController' do |ss|
    ss.source_files = 'Globus/SplitViewController/**/*.{h,m}'
    ss.dependency 'Globus/TransitionController/Base'
    ss.dependency 'Globus/UIKit/ViewController'
    ss.dependency 'Globus/UIKit/Device'
  end
  s.subspec 'ViewController' do |ss|
    ss.source_files = 'Globus/ViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
  end
  s.subspec 'PopoverController' do |ss|
    ss.source_files = 'Globus/PopoverController/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/Base'
  end
  s.subspec 'GeoLocationManager' do |ss|
    ss.source_files = 'Globus/GeoLocationManager/**/*.{h,m}'
    ss.ios.frameworks = 'CoreLocation'
    ss.watchos.frameworks = 'CoreLocation'
    ss.dependency 'Globus/CoreFoundation/String'
    ss.dependency 'Globus/UIKit/Device'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'NotificationManager' do |ss|
    ss.source_files = 'Globus/NotificationManager/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/UIKit/Application'
    ss.dependency 'Globus/UIKit/Window'
    ss.dependency 'Globus/UIKit/View'
  end
  s.subspec 'Style' do |ss|
    ss.source_files = 'Globus/Style/**/*.{h,m}'
    ss.dependency 'Globus/UIKit/Base'
  end
  s.subspec 'AppGroupNotificationCenter' do |ss|
    ss.source_files = 'Globus/AppGroupNotificationCenter/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/CoreFoundation/Dictionary'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'WebViewController' do |ss|
    ss.source_files = 'Globus/WebViewController/**/*.{h,m}'
    ss.ios.weak_framework = 'WebKit'
    ss.resources = 'Globus/WebViewController/GLBWebViewController.bundle'
    ss.dependency 'Globus/ViewController'
  end
  s.subspec 'Moon' do |ss|
    ss.source_files = 'Globus/Moon/**/*.{h,m}'
    ss.resources = 'Globus/Moon/GLBMoon.bundle'
    ss.dependency 'Globus/CoreFoundation/Base'
  end
  s.subspec 'AudioSession' do |ss|
    ss.source_files = 'Globus/AudioSession/**/*.{h,m}'
    ss.ios.frameworks = 'UIKit'
    ss.ios.frameworks = 'AVFoundation'
    ss.ios.frameworks = 'MediaPlayer'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/Observer'
  end
  s.subspec 'AudioPlayer' do |ss|
    ss.source_files = 'Globus/AudioPlayer/**/*.{h,m}'
    ss.dependency 'Globus/AudioSession'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'AudioRecorder' do |ss|
    ss.source_files = 'Globus/AudioRecorder/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation/FileManager'
    ss.dependency 'Globus/AudioSession'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'VideoPlayerView' do |ss|
    ss.source_files = 'Globus/VideoPlayerView/**/*.{h,m}'
    ss.ios.frameworks = 'AVFoundation'
    ss.dependency 'Globus/UIKit/View'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'WatchManager' do |ss|
    ss.source_files = 'Globus/WatchManager/**/*.{h,m}'
    ss.ios.frameworks = 'WatchConnectivity'
    ss.watchos.frameworks = 'WatchConnectivity'
    ss.dependency 'Globus/CoreFoundation/Dictionary'
    ss.dependency 'Globus/CoreFoundation/Array'
    ss.dependency 'Globus/CoreFoundation/FileManager'
    ss.dependency 'Globus/UIKit/Device'
  end
end
