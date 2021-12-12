//
//  Day6.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox
import CountedSet

final class Day6: Day {
    private func calculate(input: String, for days: Int) -> CustomStringConvertible {
        var birthdayCountsByDay = input
            .byCommas
            .integers
            .reduce(into: Dictionary<Int, Int>()) { $0[$1 + 1, default: 0] += 1 }

        for day in 1 ... days {
            let newBirths = (0 ... day/7)
                .map { birthdayCountsByDay[day - $0*7, default: 0] }
                .sum

            birthdayCountsByDay[day + 9, default: 0] += newBirths
        }

        return birthdayCountsByDay.map(\.value).sum

    }

    func part1(_ input: String) -> CustomStringConvertible {
        return calculate(input: input, for: 80)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return calculate(input: input, for: 256)
    }
}
