//
//  Array+Helpers.swift
//  AdventOfCode
//
//  Created by ahmet.karalar on 02/12/2021.
//

import Foundation

public extension Array {
    public subscript(safeAt index: Int) -> Element? {
        guard index < endIndex else { return nil }
        return self[index]
    }

    public func slidingGroup(of length: Int) -> Array<Array<Element>> {
        var groups: [[Element]] = []
        for (index, item) in zip(self.indices, self) {
            for i in 0 ..< length {
                let diff = index - i
                if diff < 0, diff < startIndex { continue }

                if diff >= groups.endIndex {
                    groups.append([item])
                } else {
                    var group = groups[diff]
                    group.append(item)
                    groups[diff] = group
                }
            }
        }

        return groups
    }
}

public extension Array where Element: Numeric {
    var sum: Element { reduce(0, +) }
}
