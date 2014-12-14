#
# Be sure to run `pod lib lint OADTracer.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "OADTracer"
  s.version          = "0.1.0"
  s.summary          = "OADTracer is a cocoapod that facilitates the sending of DTrace commands."
  s.description      = <<-DESC
OADTracer is a cocoapod that facilitates the sending of DTrace commands. OADTracer exposes methods for sending `NSURLRequest` and `NSURLResponse` as JSON strings to DTRace.
                       DESC
  s.homepage         = "https://github.com/oarrabi/OADTracer"
  s.license          = 'MIT'
  s.author           = { "Omar Abdelhafith" => "o.arrabi@me.com" }
  s.source           = { :git => "https://github.com/oarrabi/OADTracer", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ifnottrue'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'OADTracer' => ['Pod/Assets/*.png']
  }

end
