//
//  Day3.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

final class Day3: Day {
    func digitCountSets(for values: [String]) -> [NSCountedSet] {
        let counts = (0..<values.first!.count).map { _ in NSCountedSet() }
        for value in values {
            for (index, binary) in value.enumerated() {
                counts[index].add(String(binary))
            }
        }
        return counts
    }
    func part1(_ input: String) -> CustomStringConvertible {
        let values = input.lines

        let counts = digitCountSets(for: values)

        let gamma = counts
            .map { countSet in
                countSet.max { lhs, rhs in
                    countSet.count(for: lhs) > countSet.count(for: rhs)
                } as! String
            }
            .joined()
        let epsilon = gamma.map { $0 == "0" ? "1" : "0" }.joined()
        return (Int(gamma, radix: 2) ?? 0) * (Int(epsilon, radix: 2) ?? 0)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return 0
    }
}
