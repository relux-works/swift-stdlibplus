import Foundation

public protocol ISecureStore {
    func getValue<T: Decodable>(key: String) ->  Result<T?, SecureStoreError>
    func setValue<T: Encodable>(key: String, value: T?) -> Result<Void, SecureStoreError>
    func removeValue(key: String) -> Result<Void, SecureStoreError>
}

public class SecureStore: ISecureStore {
    private let keychain: Keychain

    private let decoder: JSONDecoder = .init()
    private let encoder: JSONEncoder = .init()

    public init (
            groupId: String,
            synchronizable: Bool
    ) {
        self.keychain = Keychain(service: groupId)
                .synchronizable(synchronizable)
    }

    public func getValue<T: Decodable>(key: String) -> Result<T?, SecureStoreError> {
        guard let rawValue = keychain[data: key] else {
            return .success(nil)
        }

        do {
            let decodedValue = try self.decoder.decode(T.self, from: rawValue)
            return .success(decodedValue)
        } catch {
            let _ = removeValue(key: key)
            return .failure(.failedToGetValue(key: key, message: error.asString))
        }
    }

    public func setValue<T: Encodable>(key: String, value: T?) -> Result<Void, SecureStoreError> {
        let removeRes = removeValue(key: key)
        switch removeRes {
        case .success: break
        case .failure: return removeRes
        }

        do {
            keychain[data: key] = try encoder.encode(value)
            return .success(())
        } catch {
            return .failure(.failedToSetValue(key: key, message: error.asString))
        }
    }

    public func removeValue(key: String) -> Result<Void, SecureStoreError> {
        do {
            try keychain.remove(key)
            return .success(())
        } catch {
            return .failure(.failedToRemoveValue(key: key, message: error.asString))
        }
    }
}
