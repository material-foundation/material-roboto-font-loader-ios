Pod::Spec.new do |s|
  s.name         = "MDFRobotoFontLoader"
  s.summary      = "MDFRobotoFontLoader"
  s.version      = "1.3.0"
  s.authors      = "The Material Foundation Authors"
  s.license      = "Apache 2.0"
  s.homepage     = "https://github.com/material-foundation/material-roboto-font-loader-ios"
  s.source       = { :git => "https://github.com/material-foundation/material-roboto-font-loader-ios.git", :tag => "v" + s.version.to_s }
  s.platform     = :ios, "7.0"
  s.requires_arc = true
  s.default_subspec = "RobotoFontLoader"

  s.subspec "RobotoFontLoader" do |ss|
    ss.public_header_files = "src/*.h"
    ss.source_files = "src/*.{h,m,mm}", "src/private/*.{h,m,mm}"
    ss.resources = ["src/MaterialRobotoFontLoader.bundle"]
    ss.dependency 'MDFFontDiskLoader'
  end

  s.subspec "MDCTypographyAdditions" do |ss|
    ss.public_header_files = "src/MDCTypographyAdditions/*.h"
    ss.source_files = "src/MDCTypographyAdditions/*.{h,m,mm}", "src/MDCTypographyAdditions/private/*.{h,m,mm}"
    ss.dependency 'MDFRobotoFontLoader/RobotoFontLoader'
    ss.dependency 'MaterialComponents/Typography'
  end

end
