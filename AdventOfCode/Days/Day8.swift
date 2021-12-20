//
//  Day8.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox
import CountedSet

final class Day8: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let uniquePatternCounts: Set<Int> = [2, 3, 4, 7]

        return input
            .byNewlines
            .map { $0.byPipes[1] }
            .flatMap(\.bySpaces)
            .filter { uniquePatternCounts.contains($0.count) }
            .count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        /*
           0:      1:      2:      3:      4:
          aaaa    ....    aaaa    aaaa    ....
         b    c  .    c  .    c  .    c  b    c
         b    c  .    c  .    c  .    c  b    c
          ....    ....    dddd    dddd    dddd
         e    f  .    f  e    .  .    f  .    f
         e    f  .    f  e    .  .    f  .    f
          gggg    ....    gggg    gggg    ....

           5:      6:      7:      8:      9:
          aaaa    aaaa    aaaa    aaaa    aaaa
         b    .  b    .  .    c  b    c  b    c
         b    .  b    .  .    c  b    c  b    c
          dddd    dddd    ....    dddd    dddd
         .    f  e    f  .    f  e    f  .    f
         .    f  e    f  .    f  e    f  .    f
          gggg    gggg    ....    gggg    gggg
        */

        let digitsBySegments: [String: String] = [
            "abcefg": "0",
            "cf": "1",
            "acdeg": "2",
            "acdfg": "3",
            "bcdf": "4",
            "abdfg": "5",
            "abdefg": "6",
            "acf": "7",
            "abcdefg": "8",
            "abcdfg": "9",
        ]

        return input
            .byNewlines
            .map {
                let cipherAndDigits = $0.byPipes
                let mapping = deduceMapping(cipherAndDigits[0])
                let number = cipherAndDigits[1]
                    .bySpaces
                    .map { numberString in
                        let key = String(numberString.map { mapping[$0]! }.sorted())
                        return digitsBySegments[key]!
                    }
                    .joined()

                return Int(number)!
            }
            .reduce(0, +)
    }

    private func deduceMapping(_ allNumbers: String) -> [Character: Character] {
        /*
         number of times each segment appears for digits 0-9:
         9 times: f
         8 times: a, c
         7 times: d, g
         6 times: b
         4 times: e

         number of segments for digits
         7 segments = 8
         6 segments = 0, 6, 9
         5 segments = 2, 3, 5
         4 segments = 4
         3 segments = 7
         2 segments = 1

         We can find out mapping for b, e and f easily because
         number of times they appear in digits 0-9 is unique.

         We can also find exact mapping for digits 1, 4 and 7 because
         number of segments for them are unique.

         To find a, we take the difference between 7 and 1.
         After finding a, we can easily find c because only these
         two segments appear 8 times in digits 0-9.

         To find d, we take the difference between 4 and 1, and subtract b.
         After finding d, we can easily find g because only these
         two segments appear 7 times in digits 0-9.
         */

        let digits = allNumbers.bySpaces.map(Set.init)

        let one = digits.filter { $0.count == 2}[0]
        let four = digits.filter { $0.count == 4 }[0]
        let seven = digits.filter { $0.count == 3 }[0]

        let segmentCounts = CountedSet(digits.flatMap { $0 })
        let allSegments = Set("abcdefg")
        var mapping: [Character: Character] = [:]
        for segment in allSegments where segmentCounts.count(for: segment) == 6 {
            mapping["b"] = segment
        }
        mapping["a"] = seven.subtracting(one).first
        mapping["d"] = four.subtracting(one).subtracting([mapping["b"]!]).first
        for segment in allSegments where !mapping.values.contains(segment) {
            switch segmentCounts.count(for: segment) {
            case 9: mapping["f"] = segment
            case 6: mapping["b"] = segment
            case 4: mapping["e"] = segment
            case 8: mapping["c"] = segment
            case 7: mapping["g"] = segment
            default: break
            }
        }

        return mapping.swappingKeysValues()
    }
}

