import KeychainAccess
import Foundation
import SwiftUI


public protocol ISecureStore {
    func getDeviceId() -> Result<String, SecureStoreError>
    func dropDeviceId() -> Result<Void, SecureStoreError>
    func getValue<T: Decodable>(key: String) ->  Result<T?, SecureStoreError>
    func getValue<T: Decodable>(key: String, keychain: SecureStore.StorageType) -> Result<T?, SecureStoreError>
    func setValue<T: Encodable>(key: String, value: T?) -> Result<Void, SecureStoreError>
    func setValue<T: Encodable>(key: String, value: T?, keychain: SecureStore.StorageType) -> Result<Void, SecureStoreError>
}

public class SecureStore: ISecureStore {
    private let localKeychain: Keychain
    private let sharedKeychain: Keychain?

    private let decoder: JSONDecoder = .init()
    private let encoder: JSONEncoder = .init()
    private let defaultKeychainType = StorageType.local

    public init (
            sharedGroupId: String? = nil
    ) {
        self.localKeychain = Keychain(service: Bundle.main.bundleIdentifier!)
        if let sharedGroupId = sharedGroupId {
            self.sharedKeychain = Keychain(service: sharedGroupId)
            // .synchronizable(true)
        } else {
            self.sharedKeychain = nil
        }
    }

    public func getDeviceId() -> Result<String, SecureStoreError> {
        let result: Result<String?, SecureStoreError> = getValue(key: Keys.deviceId)

        switch result {
        case let .success(id):
            switch id {
            case .none:
                let newId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
                switch setValue(key: Keys.deviceId, value: newId) {
                case .success:
                    return .success(newId)
                case let .failure(err):
                    return .failure(err)
                }
            case let .some(val):
                return .success(val)
            }
        case let .failure(err):
            return .failure(err)
        }
    }

    public func dropDeviceId() -> Result<Void, SecureStoreError> {
        let droppedId: String? = nil
        return setValue(key: Keys.deviceId, value: droppedId)
    }

    public func getValue<T: Decodable>(key: String) -> Result<T?, SecureStoreError> {
        getValue(key: key, keychain: defaultKeychainType)
    }

    public func getValue<T: Decodable>(key: String, keychain: StorageType) -> Result<T?, SecureStoreError> {
        guard let keychain = getKeychain(keychain) else {
            return .failure(.init(sender: self, message: "failed to get keychain"))
        }

        guard let rawValue = keychain[key] else {
            return .success(nil)
        }

        do {
            let decodedValue = try self.decoder.decode(T.self, from: Data(rawValue.utf8))
            return .success(decodedValue)
        } catch {
            try? keychain.remove(key)
            return .failure(.init(sender: self, message: "failed to get value for key: \(key)", error: error))
        }
    }

    public func setValue<T: Encodable>(key: String, value: T?) -> Result<Void, SecureStoreError> {
        setValue(key: key, value: value, keychain: defaultKeychainType)
    }

    public func setValue<T: Encodable>(key: String, value: T?, keychain: StorageType) -> Result<Void, SecureStoreError> {
        guard let keychain = getKeychain(keychain) else {
            return .failure(.init(sender: self, message: "failed to get keychain"))
        }

        do {
            guard let value = value else {
                try keychain.remove(key)
                return .failure(.init(sender: self, message: "failed to remove value for key: \(key)"))
            }

            let rawValue = try encoder.encode(value)

            guard let encodedValue = String(data: rawValue, encoding: .utf8) else {
                return .failure(.init(sender: self, message: "failed to encode value for key: \(key)"))
            }

            keychain[key] = encodedValue

            return .success(())
        } catch {
            return .failure(.init(sender: self, message: "failed to set value for key: \(key)", error: error))
        }
    }

    private func getKeychain(_ type: StorageType) -> Keychain? {
        switch type {
        case .local:
            return localKeychain
        case .shared:
            return sharedKeychain
        }
    }
}
