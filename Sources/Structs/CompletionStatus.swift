import Foundation

public enum CompletionStatus: Hashable, Equatable {
    case initial
    case progress
    case failed
    case succeed
}
