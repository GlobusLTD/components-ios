Pod::Spec.new do |s|
  s.name = 'Globus'
  s.version = '0.1.62'
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

  s.subspec 'Dev' do |ss|
    ss.dependency 'Globus/Grid'
    ss.dependency 'Globus/Action'
    ss.dependency 'Globus/Timer'
    ss.dependency 'Globus/Timeout'
    ss.dependency 'Globus/Observer'
    ss.dependency 'Globus/RegExpParser'
    ss.dependency 'Globus/TaskManager'
    ss.dependency 'Globus/ApiManager'
    ss.dependency 'Globus/Model'
    ss.dependency 'Globus/ManagedModel'
    ss.dependency 'Globus/DataSource'
    ss.dependency 'Globus/Window'
    ss.dependency 'Globus/TextField'
    ss.dependency 'Globus/DateField'
    ss.dependency 'Globus/ListField'
    ss.dependency 'Globus/PhoneField'
    ss.dependency 'Globus/TextView'
    ss.dependency 'Globus/BlurView'
    ss.dependency 'Globus/Button'
    ss.dependency 'Globus/LayoutView'
    ss.dependency 'Globus/LoadedView'
    ss.dependency 'Globus/PageControl'
    ss.dependency 'Globus/RoundView'
    ss.dependency 'Globus/TouchView'
    ss.dependency 'Globus/ScrollView'
    ss.dependency 'Globus/SearchBar'
    ss.dependency 'Globus/DataView'
    ss.dependency 'Globus/PressAndHoldGestureRecognizer'
    ss.dependency 'Globus/TransitionController'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/DialogViewController'
    ss.dependency 'Globus/PageViewController'
    ss.dependency 'Globus/SlideViewController'
    ss.dependency 'Globus/NavigationViewController'
    ss.dependency 'Globus/TabBarViewController'
    ss.dependency 'Globus/SplitViewController'
    ss.dependency 'Globus/ViewController'
    ss.dependency 'Globus/PopoverController'
    ss.dependency 'Globus/GeoLocationManager'
    ss.dependency 'Globus/NotificationManager'
    ss.dependency 'Globus/Style'
    ss.dependency 'Globus/AppGroupNotificationCenter'
    ss.dependency 'Globus/WebViewController'
    ss.dependency 'Globus/Moon'
    ss.dependency 'Globus/AudioSession'
    ss.dependency 'Globus/AudioPlayer'
    ss.dependency 'Globus/AudioRecorder'
    ss.dependency 'Globus/VideoPlayerView'
  end
  s.subspec 'CoreFoundation' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_CORE_FOUNDATION'
    }
    ss.source_files = 'Globus/CoreFoundation/**/*.{h,m}'
    ss.ios.frameworks = 'Foundation'
    ss.watchos.frameworks = 'Foundation'
  end
  s.subspec 'CoreGraphics' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_CORE_GRAPHICS'
    }
    ss.source_files = 'Globus/CoreGraphics/**/*.{h,m}'
    ss.ios.frameworks = 'CoreGraphics'
    ss.ios.frameworks = 'QuartzCore'
    ss.watchos.frameworks = 'CoreGraphics'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'CoreAnimation' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_CORE_ANIMATION'
    }
    ss.source_files = 'Globus/CoreAnimation/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'UIKit' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_UI_KIT'
    }
    ss.source_files = 'Globus/UIKit/**/*.{h,m}'
    ss.ios.frameworks = 'UIKit'
    ss.watchos.frameworks = 'UIKit'
    ss.dependency 'Globus/CoreFoundation'
    ss.dependency 'Globus/CoreGraphics'
  end
  s.subspec 'Grid' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_GRID'
    }
    ss.source_files = 'Globus/Grid/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'Action' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_ACTION'
    }
    ss.source_files = 'Globus/Action/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'Timer' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TIMER'
    }
    ss.source_files = 'Globus/Timer/**/*.{h,m}'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'Timeout' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TIMEOUT'
    }
    ss.source_files = 'Globus/Timeout/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'Observer' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_OBSERVER'
    }
    ss.source_files = 'Globus/Observer/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'KVO' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_KVO'
    }
    ss.source_files = 'Globus/KVO/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'RegExpParser' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_REG_EXP_PARSER'
    }
    ss.source_files = 'Globus/RegExpParser/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'TaskManager' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TASK_MANAGER'
    }
    ss.source_files = 'Globus/TaskManager/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'Model' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_MODEL'
    }
    ss.source_files = 'Globus/Model/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'ManagedModel' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_MANAGED_MODEL'
    }
    ss.source_files = 'Globus/ManagedModel/**/*.{h,m}'
    ss.ios.frameworks = 'CoreData'
    ss.watchos.frameworks = 'CoreData'
    ss.dependency 'Globus/Model'
  end
  s.subspec 'Cache' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_CACHE'
    }
    ss.source_files = 'Globus/Cache/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
    ss.dependency 'Globus/CoreGraphics'
    ss.dependency 'Globus/Timer'
    ss.dependency 'Globus/Model'
  end
  s.subspec 'ApiManager' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_API_MANAGER'
    }
    ss.source_files = 'Globus/ApiManager/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'DataSource' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_DATA_SOURCE'
    }
    ss.source_files = 'Globus/DataSource/**/*.{h,m}'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'SpinnerView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_SPINNER_VIEW'
    }
    ss.source_files = 'Globus/SpinnerView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
    ss.dependency 'Globus/CoreAnimation'
  end
  s.subspec 'BlurView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_BLUR_VIEW'
    }
    ss.source_files = 'Globus/BlurView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'ActivityView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_ACTIVITY_VIEW'
    }
    ss.source_files = 'Globus/ActivityView/**/*.{h,m}'
    ss.dependency 'Globus/SpinnerView'
    ss.dependency 'Globus/BlurView'
  end
  s.subspec 'InputValidation' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_INPUT_VALIDATION'
    }
    ss.source_files = 'Globus/InputValidation/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'TextField' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TEXT_FIELD'
    }
    ss.source_files = 'Globus/TextField/**/*.{h,m}'
    ss.dependency 'Globus/InputValidation'
  end
  s.subspec 'DateField' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_DATE_FIELD'
    }
    ss.source_files = 'Globus/DateField/**/*.{h,m}'
    ss.dependency 'Globus/TextField'
  end
  s.subspec 'ListField' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_LIST_FIELD'
    }
    ss.source_files = 'Globus/ListField/**/*.{h,m}'
    ss.dependency 'Globus/TextField'
  end
  s.subspec 'PhoneField' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_PHONE_FIELD'
    }
    ss.source_files = 'Globus/PhoneField/**/*.{h,m}'
    ss.dependency 'Globus/TextField'
  end
  s.subspec 'TextView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TEXT_VIEW'
    }
    ss.source_files = 'Globus/TextView/**/*.{h,m}'
    ss.dependency 'Globus/InputValidation'
  end
  s.subspec 'BadgeView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_BADGE_VIEW'
    }
    ss.source_files = 'Globus/BadgeView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'Button' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_BUTTON'
    }
    ss.source_files = 'Globus/Button/**/*.{h,m}'
    ss.dependency 'Globus/BadgeView'
  end
  s.subspec 'LayoutView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_LAYOUT_VIEW'
    }
    ss.source_files = 'Globus/LayoutView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
    ss.dependency 'Globus/KVO'
  end
  s.subspec 'LoadedView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_LOADED_VIEW'
    }
    ss.source_files = 'Globus/LoadedView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'PageControl' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_PAGE_CONTROL'
    }
    ss.source_files = 'Globus/PageControl/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'RoundView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_ROUND_VIEW'
    }
    ss.source_files = 'Globus/RoundView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'TouchView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TOUCH_VIEW'
    }
    ss.source_files = 'Globus/TouchView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'ScrollView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_SCROLL_VIEW'
    }
    ss.source_files = 'Globus/ScrollView/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'SearchBar' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_SEARCH_BAR'
    }
    ss.source_files = 'Globus/SearchBar/**/*.{h,m}'
    ss.dependency 'Globus/BlurView'
    ss.dependency 'Globus/Button'
    ss.dependency 'Globus/TextField'
  end
  s.subspec 'DataView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_DATA_VIEW'
    }
    ss.source_files = 'Globus/DataView/**/*.{h,m}'
    ss.dependency 'Globus/Grid'
    ss.dependency 'Globus/Timeout'
    ss.dependency 'Globus/UIKit'
    ss.dependency 'Globus/SearchBar'
    ss.dependency 'Globus/PageControl'
    ss.dependency 'Globus/Window'
  end
  s.subspec 'PressAndHoldGestureRecognizer' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_PRESS_AND_HOLD_GESTURE_RECORNIZER'
    }
    ss.source_files = 'Globus/PressAndHoldGestureRecognizer/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'Window' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_WINDOW'
    }
    ss.source_files = 'Globus/Window/**/*.{h,m}'
    ss.dependency 'Globus/ActivityView'
  end
  s.subspec 'TransitionController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TRANSITION_CONTROLLER'
    }
    ss.source_files = 'Globus/TransitionController/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'BaseViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_BASE_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/BaseViewController/**/*.{h,m}'
    ss.dependency 'Globus/TransitionController'
    ss.dependency 'Globus/Window'
  end
  s.subspec 'DialogViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_DIALOG_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/DialogViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/SlideViewController'
    ss.dependency 'Globus/BlurView'
  end
  s.subspec 'SlideViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_SLIDE_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/SlideViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
  end
  s.subspec 'PageViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_PAGE_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/PageViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/SlideViewController'
  end
  s.subspec 'NavigationViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_NAVIGATION_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/NavigationViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/SlideViewController'
  end
  s.subspec 'TabBarViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_TAB_BAR_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/TabBarViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/SlideViewController'
  end
  s.subspec 'SplitViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_SPLIT_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/SplitViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/SlideViewController'
  end
  s.subspec 'ViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/ViewController/**/*.{h,m}'
    ss.dependency 'Globus/BaseViewController'
    ss.dependency 'Globus/ActivityView'
  end
  s.subspec 'PopoverController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_POPOVER_CONTROLLER'
    }
    ss.source_files = 'Globus/PopoverController/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'GeoLocationManager' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_GEO_LOCATION_MANAGER'
    }
    ss.source_files = 'Globus/GeoLocationManager/**/*.{h,m}'
    ss.ios.frameworks = 'CoreLocation'
    ss.watchos.frameworks = 'CoreLocation'
    ss.dependency 'Globus/Action'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'NotificationManager' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_NOTIFICATION_MANAGER'
    }
    ss.source_files = 'Globus/NotificationManager/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'Style' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_STYLE'
    }
    ss.source_files = 'Globus/Style/**/*.{h,m}'
    ss.dependency 'Globus/UIKit'
  end
  s.subspec 'AppGroupNotificationCenter' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_APP_GROUP_NOTIFICATION_CENTER'
    }
    ss.source_files = 'Globus/AppGroupNotificationCenter/**/*.{h,m}'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'WebViewController' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_WEB_VIEW_CONTROLLER'
    }
    ss.source_files = 'Globus/WebViewController/**/*.{h,m}'
    ss.ios.weak_framework = 'WebKit'
    ss.resources = 'Globus/WebViewController/GLBWebViewController.bundle'
    ss.dependency 'Globus/ViewController'
  end
  s.subspec 'Moon' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_MOON'
    }
    ss.source_files = 'Globus/Moon/**/*.{h,m}'
    ss.resources = 'Globus/Moon/GLBMoon.bundle'
  end
  s.subspec 'AudioSession' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_AUDIO_SESSION'
    }
    ss.source_files = 'Globus/AudioSession/**/*.{h,m}'
    ss.ios.frameworks = 'AVFoundation'
    ss.ios.frameworks = 'MediaPlayer'
    ss.ios.frameworks = 'UIKit'
    ss.dependency 'Globus/CoreFoundation'
  end
  s.subspec 'AudioPlayer' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_AUDIO_PLAYER'
    }
    ss.source_files = 'Globus/AudioPlayer/**/*.{h,m}'
    ss.dependency 'Globus/AudioSession'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'AudioRecorder' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_AUDIO_RECORDER'
    }
    ss.source_files = 'Globus/AudioRecorder/**/*.{h,m}'
    ss.dependency 'Globus/AudioSession'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'VideoPlayerView' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_VIDEO_PLAYER_VIEW'
    }
    ss.source_files = 'Globus/VideoPlayerView/**/*.{h,m}'
    ss.dependency 'Globus/AudioSession'
    ss.dependency 'Globus/UIKit'
    ss.dependency 'Globus/Action'
  end
  s.subspec 'WatchManager' do |ss|
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => 'GLOBUS_WATCH_MANAGER'
    }
    ss.source_files = 'Globus/WatchManager/**/*.{h,m}'
    ss.ios.frameworks = 'WatchConnectivity'
    ss.dependency 'Globus/CoreFoundation'
    ss.dependency 'Globus/UIKit'
  end
end
