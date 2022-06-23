import Foundation

public enum FileError: Error {
    case unableToCreateFile(cause: Error)
    case unableToDeleteFile(cause: Error)
    case unableToCopyFile(cause: Error)
    case unableToReadFile(cause: Error)
    case bundleResourceIncorrectUrl(name: String, ext: String)
}