xcodebuild archive \
 -scheme GalenIT.CoreSDK \
 -archivePath ./Archives/sdk-iphoneos \
 -sdk iphoneos \
 SKIP_INSTALL=NO
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES