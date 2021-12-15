import Foundation
import SwiftUI

public struct FaceRecognitionResult {
    public let img: UIImage?
    public let valid: Bool
    public let features: FaceFeatures?
    
    public init(
        img: UIImage?,
        valid: Bool,
        features: FaceFeatures?
    ) {
        self.img = img
        self.valid = valid
        self.features = features
    }
}
