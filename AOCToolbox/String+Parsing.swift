//
//  String+Parsing.swift
//  AdventOfCode
//
//  Created by ahmet.karalar on 02/12/2021.
//

import Foundation

public protocol StringInitializable {
    init?(_ description: String)
}

public extension StringInitializable where Self: RawRepresentable, RawValue == String {
    init?(_ description: String) {
        self.init(rawValue: description)
    }
}

extension Int: StringInitializable { }
extension Double: StringInitializable { }

public extension String {
    var lines: [String] { rows() }
    var integers: [Int] { lines.compactMap(Int.init) }

    func rows(with delimiter: String = "\n") -> [String] {
        var lines = components(separatedBy: delimiter)
        while lines.last?.isEmpty ?? false {
            lines = lines.dropLast()
        }
        return lines
    }

    func rows<First: StringInitializable, Second: StringInitializable>(
        lineDelimiter: String = "\n",
        interItemDelimiter: String = " "
    ) -> [(First, Second)] {
        var items: [(First, Second)] = []

        for row in rows(with: lineDelimiter) {
            let rowItems = row.components(separatedBy: interItemDelimiter)
            items.append((First(rowItems.first!), Second(rowItems.last!))
        }

        return items
    }
}
