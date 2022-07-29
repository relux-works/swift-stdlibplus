import Foundation

public enum SecureStoreError: Error {
    case failedToGetValue(key: String, message: String)
    case failedToSetValue(key: String, message: String)
    case failedToRemoveValue(key: String, message: String)
}
