//
//  Day5.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

struct Point: Hashable {
    let x: Int
    let y: Int
}

extension Point: StringInitializable {
    public init?(_ description: String) {
        let coordinates = description.components(separatedBy: ",")
        x = Int(coordinates[0])!
        y = Int(coordinates[1])!
    }

    func line(to point: Point) -> [Point] {
        let xDiff = point.x - self.x
        let yDiff = point.y - self.y
        let unitVector = Point(
            x: xDiff == 0 ? 0 : xDiff / abs(xDiff),
            y: yDiff == 0 ? 0 : yDiff / abs(yDiff)
        )

        return (0 ... max(abs(xDiff), abs(yDiff)))
            .map { i in
                Point(x: self.x + (unitVector.x * i), y: self.y + (unitVector.y * i))
            }
    }
}

extension Point: CustomDebugStringConvertible {
    var debugDescription: String {
        "x: \(x), y: \(y)"
    }
}

final class Day5: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let vents: [(Point, Point)] = input.rows(lineDelimiter: "\n", interItemDelimiter: " -> ")
        var floor = Matrix<Int>()
        vents
            .filter { $0.0.x == $0.1.x || $0.0.y == $0.1.y }
            .flatMap { $0.0.line(to: $0.1) }
            .forEach { floor[$0.x, $0.y, default: 0] += 1 }

        return floor.elements { $0 >= 2 }.count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let vents: [(Point, Point)] = input.rows(lineDelimiter: "\n", interItemDelimiter: " -> ")
        var floor = Matrix<Int>()
        vents
            .flatMap { $0.0.line(to: $0.1) }
            .forEach { floor[$0.x, $0.y, default: 0] += 1 }

        return floor.elements { $0 >= 2 }.count
    }
}
