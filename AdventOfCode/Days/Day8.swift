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

        let numberLineMapping: [String: String] = [
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
                        return numberLineMapping[key]!
                    }
                    .joined()

                return Int(number)!
            }
            .reduce(0, +)
    }

    private func deduceMapping(_ allNumbers: String) -> [Character: Character] {
        /*
         number of times each segment appears for numbers 0-9:
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
         number of times they appear in numbers 0-9 is unique.

         We can also find the numbers 1, 4 and 7 because number of
         segments for them are unique.

         To find a, we take the difference between 7 and 1.
         After finding a, we can easily find c because only these
         two appear 8 times in numbers 0-9.


         To find d, we take the difference between 4 and 1, and subtract b.
         After finding d, we can easily find g because only these
         two appear 7 times in numbers 0-9.
         */

        let numberStrings = allNumbers.bySpaces.map(Set.init)

        let one = numberStrings.filter { $0.count == 2}[0]
        let four = numberStrings.filter { $0.count == 4 }[0]
        let seven = numberStrings.filter { $0.count == 3 }[0]

        let counts = CountedSet(numberStrings.flatMap { $0 })
        let chars = Set("abcdefg")
        var mapping: [Character: Character] = [:]
        for char in chars where counts.count(for: char) == 6 {
            mapping["b"] = char
        }
        mapping["a"] = seven.subtracting(one).first
        mapping["d"] = four.subtracting(one).subtracting([mapping["b"]!]).first
        for char in chars where !mapping.values.contains(char) {
            switch counts.count(for: char) {
            case 9: mapping["f"] = char
            case 6: mapping["b"] = char
            case 4: mapping["e"] = char
            case 8: mapping["c"] = char
            case 7: mapping["g"] = char
            default: break
            }
        }

        return mapping.swappingKeysValues()
    }
}

