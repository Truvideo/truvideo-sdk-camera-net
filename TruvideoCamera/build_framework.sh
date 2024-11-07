xcodebuild archive -scheme "TruvideoCamera" -destination generic/platform=iOS -archivePath "archives/TruvideoCamera_iOS" -derivedDataPath "$PWD/derivedData" -clonedSourcePackagesDirPath "$HOME/Library/Developer/Xcode/DerivedData/$XCODE_SCHEME" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive -scheme "TruvideoCamera" -destination "generic/platform=iOS Simulator" -archivePath "archives/TruvideoCamera_iOS_Simulator" -derivedDataPath "$PWD/derivedData" -clonedSourcePackagesDirPath "$HOME/Library/Developer/Xcode/DerivedData/$XCODE_SCHEME" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework -framework archives/TruvideoCamera_iOS.xcarchive/Products/Library/Frameworks/TruvideoCamera.framework -framework archives/TruvideoCamera_iOS_Simulator.xcarchive/Products/Library/Frameworks/TruvideoCamera.framework -output TruvideoCamera.xcframework

