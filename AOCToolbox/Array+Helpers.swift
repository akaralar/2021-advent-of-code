//
//  Array+Helpers.swift
//  AdventOfCode
//
//  Created by ahmet.karalar on 02/12/2021.
//

import Foundation

public extension Array {
    subscript(safeAt index: Int) -> Element? {
        guard index < endIndex else { return nil }
        return self[index]
    }

    func slidingGroup(of length: Int) -> Array<Array<Element>> {
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

public extension Array {
    func indexedDict() -> [Int: Element] {
        Dictionary(uniqueKeysWithValues: enumerated().map { index, item in (index, item) })
    }
}

public protocol NumericExpressible {
    associatedtype Value: Numeric
    var numericValue: Value { get }
    static var zero: Value { get }
}

extension Int: NumericExpressible {
    public var numericValue: Self { self }

}
extension Double: NumericExpressible {
    public var numericValue: Self { self }
}

public extension Array where Element: NumericExpressible {
    var sum: Element.Value { reduce(.zero, { $0 + $1.numericValue }) }
}

public extension Dictionary where Value: NumericExpressible {
    var sum: Value.Value { reduce(.zero, { $0 + $1.value.numericValue }) }
}
