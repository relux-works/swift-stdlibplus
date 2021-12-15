import AVFoundation

public struct CameraPermissionsHelper {
    public static var accessToVideoStatus: AVAuthorizationStatus {
        AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    }

    public static func requestCameraVideoAccess(onResult: @escaping (Bool)->()) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
            onResult(granted)
        }
    }
}
