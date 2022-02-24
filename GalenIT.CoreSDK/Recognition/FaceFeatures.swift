import Foundation
import SwiftUI

public struct FaceFeatures {
    public let faceBounds: CGRect
    public let leftEyeAt: CGPoint?
    public let leftEyeClosed: Bool?
    public let rightEyeAt: CGPoint?
    public let rightEyeClosed: Bool?
    public let faceAngle: Float?
    public let mouthAt: CGPoint?
    public let hasSmile: Bool?
    public let trackingFrameCount: Int?
    public let trackingID: Int?
}

public extension FaceFeatures {
    static func build(_ feature: CIFaceFeature) -> FaceFeatures {
        FaceFeatures(
                faceBounds: feature.bounds,
                leftEyeAt: feature.hasLeftEyePosition ? feature.leftEyePosition : nil,
                leftEyeClosed: feature.hasLeftEyePosition ? feature.leftEyeClosed : nil,
                rightEyeAt: feature.hasRightEyePosition ? feature.rightEyePosition : nil,
                rightEyeClosed: feature.hasRightEyePosition ? feature.rightEyeClosed : nil,
                faceAngle: feature.hasFaceAngle ? feature.faceAngle : nil,
                mouthAt: feature.hasMouthPosition ? feature.mouthPosition : nil,
                hasSmile: feature.hasMouthPosition,
                trackingFrameCount: feature.hasTrackingFrameCount ? Int(feature.trackingFrameCount) : nil,
                trackingID: feature.hasTrackingID ?  Int(feature.trackingID) : nil
        )
    }
}
