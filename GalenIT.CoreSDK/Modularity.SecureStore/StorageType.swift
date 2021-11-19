import Foundation

public extension SecureStore {
    enum StorageType {
        case local //only for current target
        case shared //shared between all targets with shared keychain group
    }
}
