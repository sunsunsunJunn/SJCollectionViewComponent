#
#  Be sure to run `pod spec lint SJCollectionViewComponent.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "SJCollectionViewComponent"
  spec.version      = "1.0.4"
  spec.summary      = "UICollectionView组件,一个cellModel对应一个cell，用模型控制cell的显示"
  spec.homepage     = "https://github.com/sunsunsunJunn/SJCollectionViewComponent"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "孙俊" => "sundream27@163.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/sunsunsunJunn/SJCollectionViewComponent.git", :tag => "#{spec.version}" }
  spec.source_files = "SJCollectionViewComponent/SJCollectionViewComponent/**/*.{h,m}"
  spec.requires_arc = true
end
