
Pod::Spec.new do |spec|


  spec.name         = "CKUtils"
  spec.version      = "1.1.4"
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


  spec.source_files  = "CKExstension"
#    spec.dependency "RxSwift"
#    spec.dependency "RxCocoa"
#    spec.dependency "SnapKit"
  

  spec.requires_arc = true


end
