source 'git@github.com:Four23Creative/SpecsPrivateRepo.git'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

inhibit_all_warnings!

platform :ios, '9.0'

target ‘DNCBaseScene’ do
  # Pods for DNCBaseScene
  pod 'BFKit'
  pod 'CRToast'
  pod 'PodAsset'

  pod 'DNCDataObjects'
  pod 'DNCDisabledViewController'
  
  pod 'WKRCrash_Workers'

  target 'DNCBaseSceneTests’ do
    inherit! :search_paths

    # Pods for testing
    pod 'Gizou', :git => "git@github.com:doublenode/Gizou.git"
    pod 'OCMock'
  end

end
