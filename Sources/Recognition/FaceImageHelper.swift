//import Foundation
//import SwiftUI
//
//public struct FaceImageHelper {
//    
//    public static func squareImg(_ img: UIImage?) -> UIImage? {
//        guard let img = img else { return nil }
//
//        return img.croppedToSquare(
//                rect: FaceImageHelper.calcPhotoRect(for: img)
//        )
//    }
//
//    public static func calcPhotoRect(for photo: UIImage) -> CGRect {
//        switch photo.size.width > photo.size.height {
//        case true:
//            let rectWidth = photo.size.height
//            let rectOriginX = (photo.size.width - rectWidth) / 2
//
//            return .init(x: rectOriginX, y: 0, width: rectWidth, height: photo.size.height)
//
//        case false:
//            let rectHeight = photo.size.width
//            let rectOriginY = (photo.size.height - rectHeight) / 2
//
//            return .init(x: 0, y: rectOriginY, width: photo.size.width, height: rectHeight)
//        }
//    }
//}
