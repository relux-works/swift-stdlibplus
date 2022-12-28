public extension Bool {
    var inversion: Bool {
        self.not
    }

    var not: Bool {
        !self
    }

    var negative: Bool {
        !self
    }

    var positive: Bool {
        self
    }
}

public extension Optional where Wrapped == Bool {
    var positive: Bool {
        self?.positive ?? false
    }

    var negative: Bool {
        self?.not ?? false
    }
}