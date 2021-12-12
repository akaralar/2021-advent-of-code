//
//  Day7.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

final class Day7: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let crabs = input.byCommas.integers

        var minFuel: Int = .max
        for i in crabs.min()! ..< crabs.max()! {
            let totalFuel = crabs.map { abs($0 - i) }.sum
            minFuel = min(totalFuel, minFuel)
        }
        return minFuel
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let crabs = input.byCommas.integers

        var minFuel: Int = .max
        for i in crabs.min()! ..< crabs.max()! {
            let totalFuel = crabs
                .map { abs($0 - i) }
                .map { ($0 * ($0 + 1)) / 2 }
                .sum
            minFuel = min(totalFuel, minFuel)
        }

        return minFuel
    }
}
