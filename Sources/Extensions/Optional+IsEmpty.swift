public extension Optional where Wrapped: Sequence {
    var orEmpty: Wrapped {
        self ?? [] as! Wrapped
    }
}