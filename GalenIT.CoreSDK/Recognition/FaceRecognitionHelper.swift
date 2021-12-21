import Foundation
import SwiftUI

public struct FaceRecognitionHelper {
    
    public static func compareFaces(original: UIImage, target: UIImage) -> Double {
        Double.random(in: 0.50...0.85)
    }
    
    
    public static func squareImg(_ img: UIImage?) -> UIImage? {
        guard let img = img else { return nil }

        return img.croppedToSquare(
                rect: FaceRecognitionHelper.calcPhotoRect(for: img)
        )
    }
    public static func buildRecognitionResult(_ view: UIImage?, _ faceDetection: [FaceFeatures]) -> FaceRecognitionResult {
        guard let img = view else {
            return FaceRecognitionResult(img: nil, valid: false, features: nil)
        }

        guard faceDetection.hasOne, let features = faceDetection.first else {
            return FaceRecognitionResult(
                    img: img.croppedToSquare(
                            rect: calcPhotoRect(for: img)
                    ),
                    valid: false,
                    features: nil
            )
        }


        return FaceRecognitionResult(
                img: img,
                valid: true,
                features: features
        )
    }

    public static func calcPhotoRect(for photo: UIImage) -> CGRect {
        switch photo.size.width > photo.size.height {
        case true:
            let rectWidth = photo.size.height
            let rectOriginX = (photo.size.width - rectWidth) / 2

            return .init(x: rectOriginX, y: 0, width: rectWidth, height: photo.size.height)

        case false:
            let rectHeight = photo.size.width
            let rectOriginY = (photo.size.height - rectHeight) / 2

            return .init(x: 0, y: rectOriginY, width: photo.size.width, height: rectHeight)
        }
    }

    public static func detectFaces(_ img: UIImage?) -> [FaceFeatures] {
        guard
                let img = img,
                let cgImg = img.cgImage
                else {
            return []
        }

        let ciImage = CIImage(cgImage: cgImg)

        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)!

        return faceDetector
                .features(in: ciImage)
                .compactMap { $0 as? CIFaceFeature }
                .map { FaceFeatures(
                        faceBounds: $0.bounds,
                        leftEyeAt: $0.hasLeftEyePosition ? $0.leftEyePosition : nil,
                        leftEyeClosed: $0.hasLeftEyePosition ? $0.leftEyeClosed : nil,
                        rightEyeAt: $0.hasRightEyePosition ? $0.rightEyePosition : nil,
                        rightEyeClosed: $0.hasRightEyePosition ? $0.rightEyeClosed : nil,
                        faceAngle: $0.hasFaceAngle ? $0.faceAngle : nil,
                        mouthAt: $0.hasMouthPosition ? $0.mouthPosition : nil,
                        hasSmile: $0.hasMouthPosition,
                        trackingFrameCount: $0.hasTrackingFrameCount ? Int($0.trackingFrameCount) : nil,
                        trackingID: $0.hasTrackingID ?  Int($0.trackingID) : nil
                ) }
    }
}
