#
#  Be sure to run `pod spec lint LoadingManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LoadingManager"
  s.version      = "0.0.4"
  s.summary      = "Loading helper"
  s.description  = <<-DESC
                        Loading helper!
                   DESC
  s.homepage     = "https://github.com/shenglinFL/LoadingManager"
  s.license      = "MIT"
  s.author       = { "linsheng" => "linsheng77777@163.com" }
  s.platform     = :ios, "9.0"
  s.source       = {:git => "https://github.com/shenglinFL/LoadingManager.git", :tag => "#{s.version}" }
  s.source_files = "LoadingManager/*.*"
  s.requires_arc = true
  s.frameworks   = "UIKit"

  s.swift_version = '4.0'

  s.dependency "SnapKit", "~> 4.0"
end
