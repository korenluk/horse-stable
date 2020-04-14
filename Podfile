platform :ios, '11.0'
inhibit_all_warnings!

abstract_target 'defaults' do
  use_frameworks!

  pod 'SwiftLint', '~> 0.31'
  pod 'SwiftFormat/CLI', '~> 0.38.0'
  pod 'Alamofire', '~> 4.8.2'
  pod 'KeychainSwift', '~> 13.0'
  pod 'FSCalendar'

  # App

  target 'HorseStable'

  # Tests

  target 'HorseStableTests'
  target 'HorseStableUITests'
end
