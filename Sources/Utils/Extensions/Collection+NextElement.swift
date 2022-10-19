import Foundation

public extension Collection where Element: Equatable {
    func element(after element: Element, wrapping: Bool = false) -> Element? {
        if let index = self.firstIndex(of: element){
            let followingIndex = self.index(after: index)
            if followingIndex < self.endIndex {
                return self[followingIndex]
            } else if wrapping {
                return self[self.index(after: self.endIndex)]
            }
        }
        return nil
    }

    func element(after element: Element) -> Element {
        guard let index = self.firstIndex(of: element) else {
            return self[self.startIndex]
        }
        let followingIndex = self.index(after: index)
        guard followingIndex < self.endIndex else {
            return self[self.startIndex]
        }
        return self[followingIndex]
    }
}

public extension BidirectionalCollection where Element: Equatable {
    func element(before element: Element, wrapping: Bool = false) -> Element? {
        if let index = self.firstIndex(of: element){
            let precedingIndex = self.index(before: index)
            if precedingIndex >= self.startIndex {
                return self[precedingIndex]
            } else if wrapping {
                return self[self.index(before: self.endIndex)]
            }
        }
        return nil
    }

    func element(before element: Element) -> Element {
        if let index = self.firstIndex(of: element){
            let precedingIndex = self.index(before: index)
            if precedingIndex >= self.startIndex {
                return self[precedingIndex]
            } else {
                return self[self.index(before: self.endIndex)]
            }
        } else {
            return self[self.index(before: self.endIndex)]
        }
    }
}