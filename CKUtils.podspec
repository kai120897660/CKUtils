
Pod::Spec.new do |spec|


  spec.name         = "CKUtils"
  spec.version      = "1.1.1"
  spec.summary      = "Custom Swift Utils"
  spec.description  = <<-DESC
                      this project is custom swift lib for utils   
                   DESC

  spec.homepage     = "https://github.com/kai120897660/CKUtils"

  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "陈凯文" => "kai120897660@sina.com" }

  spec.swift_version= "4.2"
  spec.platform     = :ios, "8.0"

  spec.source       = { :git => "https://github.com/kai120897660/CKUtils.git", :tag => "#{spec.version}" }


#  spec.source_files  = "CKExstension"
  spec.subspec "CkCustom" do |ss|
    ss.source_files  = "CKExstension", "Utils"
    ss.dependency "RxSwift"
    ss.dependency "RxCocoa"
    ss.dependency "SnapKit"
  end

#  spec.subspec "Admin" do |ss|
#    ss.source_files  = "Admin/**/*.swift"
#    ss.dependency "RxSwift"
#    ss.dependency "RxCocoa"
#    ss.dependency "RxDataSources"
#    ss.dependency "Moya"
#    ss.dependency "SnapKit"
#    ss.dependency "HandyJSON"
#    ss.dependency "EZOpenSDK"
#    ss.dependency "MJRefresh"
#    ss.dependency "SDWebImage"
#  end

  spec.requires_arc = true


end
