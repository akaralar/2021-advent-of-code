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

public extension Array where Element == String {
    var integers: [Int] { compactMap(Int.init) }
}

public extension String {
    var byNewlines: [String] { elements() }
    var byDoubleNewlines: [String] { elements(with: "\n\n") }
    var byCommas: [String] { elements(with: ",") }
    var byPipes: [String] { elements(with: "|") }
    var bySpaces: [String] { elements(with: " ") }

    internal func elements(with delimiter: String = "\n") -> [String] {
        var lines = trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: delimiter)
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
        for row in elements(with: lineDelimiter) {
            let rowItems = row.components(separatedBy: interItemDelimiter)
            items.append((rowItems.first.flatMap(First.init)!, rowItems.last.flatMap(Second.init)!))
        }

        return items
    }
}
