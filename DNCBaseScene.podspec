Pod::Spec.new do |s|

  s.name         = "DNCBaseScene"
  s.version      = "0.4.7"
  s.summary      = "A base class for scenes."

  s.description  = <<-DESC
                    A base class which defines common methods/properties for scenes.
                   DESC

  s.homepage     = "https://github.com/DoubleNode/Pod_DNCBaseScene"
  s.license      = { :type => "PRIVATE", :file => "README.md" }

  s.author             = { "Darren Ehlers" => "me@darrenehlers.com" }
  s.social_media_url   = "http://twitter.com/ehlersd"

  s.platform        = :ios, "11.0"
  s.source          = { :git => "https://github.com/DoubleNode/Pod_DNCBaseScene.git", :tag => "#{s.version}" }
  s.swift_version   = "4.2"

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.public_header_files = "Classes/**/*.h"

  s.resource_bundles =
  {
    'DNCBaseScene' => ['Classes/**/*.xib']
  }

  s.library   = "stdc++"

  s.requires_arc = true

  s.dependency "DNCDataObjects"
  
  s.dependency "WKRCrash_Workers"

  s.dependency "BFKit"
  s.dependency "CRToast"
  s.dependency "PodAsset"

end
