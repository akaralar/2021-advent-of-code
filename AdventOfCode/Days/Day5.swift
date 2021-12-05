//
//  Day5.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

struct Point {
    let x: Int
    let y: Int
}

struct OceanFloor {
    let matrix: Matrix<Int>
}

extension Point: StringInitializable {
    public init?(_ description: String) {
        let coordinates = description.components(separatedBy: ",")
        x = Int(coordinates[0])!
        y = Int(coordinates[1])!
    }
}

final class Day5: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let vents: [(Point, Point)] = input.rows(lineDelimiter: "\n", interItemDelimiter: " -> ")
        var floor = Matrix<Int>()

        for vent in vents {
            let (start, end) = vent
            if start.x == end.x {
                for y in min(start.y, end.y) ... max(start.y, end.y) {
                    floor[start.x, y, default: 0] += 1
                }
            } else if start.y == end.y {
                for x in min(start.x, end.x) ... max(start.x, end.x) {
                    floor[x, start.y, default: 0] += 1
                }
            } else {
                // skip for part 1
            }
        }

        return floor.elements { $0 >= 2 }.count
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let vents: [(Point, Point)] = input.rows(lineDelimiter: "\n", interItemDelimiter: " -> ")
        var floor = Matrix<Int>()

        for vent in vents {
            let (start, end) = vent
            if start.x == end.x {
                for y in min(start.y, end.y) ... max(start.y, end.y) {
                    floor[start.x, y, default: 0] += 1
                }
            } else if start.y == end.y {
                for x in min(start.x, end.x) ... max(start.x, end.x) {
                    floor[x, start.y, default: 0] += 1
                }
            } else {
                if (start.x > end.x && start.y > end.y) || (start.x < end.x && start.y < end.y) {
                    let minX = min(start.x, end.x)
                    let minY = min(start.y, end.y)
                    for i in 0 ... abs(start.x - end.x) {
                        let x = minX + i
                        let y = minY + i
                        floor[x, y, default: 0] += 1
                    }
                } else {
                    let minX = min(start.x, end.x)
                    let maxY = max(start.y, end.y)
                    for i in 0 ... abs(start.x - end.x) {
                        let x = minX + i
                        let y = maxY - i
                        floor[x, y, default: 0] += 1
                    }

                }
            }
        }

        return floor.elements { $0 >= 2 }.count
    }
}
