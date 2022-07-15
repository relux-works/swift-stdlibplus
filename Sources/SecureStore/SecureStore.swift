import Foundation

public protocol ISecureStore {
    func getValue<T: Decodable>(key: String) ->  Result<T?, SecureStoreError>
    func setValue<T: Encodable>(key: String, value: T?) -> Result<Void, SecureStoreError>
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
}
