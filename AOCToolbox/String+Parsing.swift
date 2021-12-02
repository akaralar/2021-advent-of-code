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
        let lines = components(separatedBy: delimiter)
        return Array(lines.reversed().drop(while: \.isEmpty).reversed())
    }

    func rows<First: StringInitializable, Second: StringInitializable>(
        lineDelimiter: String = "\n",
        interItemDelimiter: String = " "
    ) -> [(First, Second)] {
        rows(with: lineDelimiter)
            .map { $0.components(separatedBy: interItemDelimiter) }
            .map { ($0.first.flatMap(First.init)!, $0.last.flatMap(Second.init)!) }
    }
}
