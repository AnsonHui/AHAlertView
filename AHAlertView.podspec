Pod::Spec.new do |s|
  s.name         = "AHAlertView"
  s.version      = "1.0.0"
  s.summary      = "代替系统自带的UIAlertView，在保持UIAlertView使用代理的习惯，还支持Block形式。支持多按钮选项。"
  s.homepage     = "http://git.ipd.meizu.com/dayu/DyAlertView"
  s.license      = "MIT"
  s.author             = { "黄辉" => "fantasyhui@126.com" }
  s.source       = { :git => "https://github.com/AnsonHui/AHAlertView.git", :tag => s.version }
  s.source_files  = "Classes/*.swift"
  s.resources    = 'Resources/**/*.{svg,png,xib}'
  s.requires_arc = true
  s.ios.deployment_target = "8.0"
  s.dependency "AHAutoLayout-Swift", "~> 1.0.0"

end
