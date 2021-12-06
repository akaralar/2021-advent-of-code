//
//  Matrix.swift
//  AOCToolbox
//
//  Created by ahmet.karalar on 05/12/2021.
//

import Foundation

public struct Matrix<Element: StringInitializable> {
    private var values: [Int: [Int: Element]] = [:]

    private(set) public var capacity: (width: Int, height: Int) = (0, 0)

    public subscript(x: Int, y: Int) -> Element? {
        get {
            values[y]?[x]
        }
        set(newValue) {
            values[y]?[x] = newValue
        }
    }

    public subscript(x: Int, y: Int, default value: Element) -> Element {
        get {
            values[y]?[x] ?? value
        }
        set(newValue) {
            if x > capacity.width { capacity = (x, capacity.height) }
            if y > capacity.height { capacity = (capacity.width, y) }

            var yValue = values[y, default: [:]]
            yValue[x] = newValue
            values[y] = yValue
        }
    }


    func allRowsSatisfy(_ predicate: (Element) -> Bool) -> Bool {
        false
    }

    public func anyRowSatisfy(_ predicate: (Element) -> Bool) -> Bool {
        values.first { $0.value.values.allSatisfy(predicate) } != nil
    }

    public func anyColumnSatisfy(_ predicate: (Element) -> Bool) -> Bool {
        for y in 0 ..< capacity.width {
            if values.compactMap ({ $0.value[y] }).allSatisfy(predicate) { return true }
        }
        return false
    }

    public func elements(_ predicate: (Element) -> Bool) -> [Element] {
        values.flatMap { $0.value.values.filter(predicate) }
    }
}

public extension Matrix {
    init(capacity: (Int, Int) = (0, 0)) {
        self.capacity = capacity
    }

    init(_ string: String, lineDelimiter: String = "\n", interItemDelimiter: CharacterSet = .whitespacesAndNewlines) {
        values = string.rows(with: lineDelimiter)
            .map { line -> [Int: Element] in
                let numbers = line.components(separatedBy: interItemDelimiter)
                    .compactMap { Element.init($0) }
                return numbers.indexedDict()
            }
            .indexedDict()

        capacity = (maxX+1, maxY+1)
    }
}

extension Matrix: CustomDebugStringConvertible {
    var maxX: Int { values.compactMapValues { $0.keys.max() }.values.max()! }
    var maxY: Int { values.keys.max()! }

    public var debugDescription: String {
        var description = ""
        for y in 0 ..< maxY {
            for x in 0 ..< maxX {
                let element = self[x, y]
                description += element.debugDescription
            }
            description = description + "\n"
        }
        return description
    }
}

