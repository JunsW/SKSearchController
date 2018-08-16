Pod::Spec.new do |s|

  s.name         = "SKSearchController"
  s.version      = "1.0.3"
  s.summary      = "A Wrap for UISearchController makes all customization super easy."

  s.description  = <<-DESC
  SKSearchController makes all the UI settings of UISearchController quick and easy. You don't have to go through subviews to find the textfield or the cancel button any more. SKSearchController has done all that for you. In addition, all the UISearchBar delegate methods have been converted to closures, which makes much faster to code.
                   DESC

  s.homepage     = "https://github.com/JunsW/SKSearchController"
  s.screenshots  = "https://github.com/JunsW/SKSearchController/blob/master/Assets/Demo.gif?raw=true"

  s.license = { type: 'MIT', file: 'LICENSE' }
  s.author             = { "JunsW" => "wjunshuo@qq.com" }
 
  s.source       = { :git => "https://github.com/JunsW/SKSearchController.git", :tag => "1.0.3" }
  s.source_files  = "Source/*.swift"

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0'
  }

  s.requires_arc = true
  s.framework  = "UIKit"
  s.swift_version = "4.0"

end
