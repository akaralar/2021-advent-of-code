//
//  Day6.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox
import CountedSet

final class Day6: Day {
    private func calculate(input: String, for days: Int) -> CustomStringConvertible {
        var birthdayCountsByDay = input.rows(with: ",")
            .compactMap(Int.init)
            .reduce(into: [Int: CountedSet<Bool>]()) { $0[$1 + 1, default: []].update(with: true) }

        for day in 1 ... days {
            let newBirths = (0 ... day/7)
                .map { day - $0*7 }
                .map { birthdayCountsByDay[$0, default: []].count(for: true) }
                .sum

            birthdayCountsByDay[day + 9, default: []].update(with: true, count: newBirths)
        }

        return birthdayCountsByDay.map { $0.1.count(for: true) }.sum

    }

    func part1(_ input: String) -> CustomStringConvertible {
        return calculate(input: input, for: 80)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return calculate(input: input, for: 256)
    }
}
