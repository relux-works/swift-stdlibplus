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
