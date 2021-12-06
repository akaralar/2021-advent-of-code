//
//  Day1.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

final class Day1: Day {
    func countOfIncrease(_ items: [Int]) -> Int {
        var count: Int = 0
        for (prev, next) in zip(items.dropLast(), items.dropFirst()) {
            if next > prev { count += 1 }
        }
        return count
    }

    func part1(_ input: String) -> CustomStringConvertible {
        return countOfIncrease(input.byNewlines.integers)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let window = input.byNewlines.integers.slidingGroup(of: 3)
        return countOfIncrease(window.map(\.sum))
    }
}
