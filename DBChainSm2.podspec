Pod::Spec.new do |spec|

  spec.name         = "DBChainSm2"
  spec.version      = "2.0.2"
  spec.summary      = "国密 SM2 的 OC 封装，基于 OpenSSL。"
#  spec.description  = <<-DESC
#  基于 OpenSSL 封装 SM2 生成密钥对,加解密,签名验签,添加根据私钥生成公钥, 公钥未压缩与压缩格式
#                      DESC

  spec.description = '基于 OpenSSL 封装 SM2 加解密、SM2 签名验签、等。'
  spec.homepage     = "https://github.com/Ann-iOS/DBChainSm2"

  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  # spec.license      = "MIT (example)"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "YangtingTombay" => "m18620345206@163.com" }

  spec.platform     = :ios
  # spec.platform     = :ios, "9.0"
  spec.ios.deployment_target = '9.0'
  #spec.source       = { :git => "https://github.com/Ann-iOS/DBChainSm2.git", :tag => "#{spec.version}" }
  spec.source       = { :git => "https://github.com/Ann-iOS/DBChainSm2.git", :tag => spec.version.to_s }
  spec.pod_target_xcconfig = { 'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)' }

  spec.source_files  = "DBChainSm2/**/*.{h,m}"
  spec.public_header_files = "DBChainSm2/**/*.h"

  spec.requires_arc     = true
  spec.static_framework = true
  spec.frameworks       = "Security"
  spec.dependency "GMOpenSSL"
end
