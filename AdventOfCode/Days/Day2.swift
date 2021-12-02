//
//  Day2.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

enum Command: String {
    case forward
    case down
    case up
}

extension Command: StringInitializable {}

final class Day2: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let commands: [(Command, Int)] = input.rows(lineDelimiter: "\n", interItemDelimiter: " ")
        var position: (horizontal: Int, vertical: Int) = (0, 0)
        for (command, value) in commands {
            switch command {
            case .forward: position.horizontal += value
            case .up: position.vertical -= value
            case .down: position.vertical += value
            }
        }

        return position.horizontal * position.vertical
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let commands: [(Command, Int)] = input.rows(lineDelimiter: "\n", interItemDelimiter: " ")
        var position: (horizontal: Int, depth: Int) = (0, 0)
        var aim = 0

        for (command, value) in commands {
            switch command {
            case .forward:
                position.horizontal += value
                position.depth += value * aim
            case .up: aim -= value
            case .down: aim += value
            }
        }

        return position.horizontal * position.depth
    }
}
