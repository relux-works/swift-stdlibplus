import Foundation

public protocol Searchable {
    func satisfies(searchPath: String) -> Bool
}