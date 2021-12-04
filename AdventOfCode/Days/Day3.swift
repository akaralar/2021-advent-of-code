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
        let lines = input.lines

        var ogrLines = lines
        var cursor = ogrLines.first!.startIndex
        while ogrLines.count != 1 {
            let counts = digitCountSets(for: ogrLines)
            let ogrBitCriteria = counts.map { $0.count(for: "1") >= $0.count(for: "0") ? "1" : "0" }.joined()
            ogrLines = ogrLines.filter { $0[cursor] == ogrBitCriteria[cursor] }
            cursor = ogrBitCriteria.index(after: cursor)
        }

        var co2srLines = lines
        cursor = co2srLines.first!.startIndex
        while co2srLines.count != 1 {
            let counts = digitCountSets(for: co2srLines)
            let co2srBitCriteria = counts
                .map { $0.count(for: "0") <= $0.count(for: "1") ? "0" : "1" }
                .joined()

            co2srLines = co2srLines.filter { $0[cursor] == co2srBitCriteria[cursor] }
            cursor = co2srBitCriteria.index(after: cursor)
        }

        guard
            let ogr = ogrLines.first,
            let co2sr = co2srLines.first,
            let ogrDecimal = Int(ogr, radix: 2),
            let co2srDecimal = Int(co2sr, radix: 2)
        else { return 0 }

        return ogrDecimal * co2srDecimal
    }
}
