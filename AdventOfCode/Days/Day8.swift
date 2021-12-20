//
//  Day8.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

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
        return 0
    }
}
