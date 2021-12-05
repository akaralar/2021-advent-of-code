//
//  Day4.swift
//  AdventOfCode
//

import Foundation
struct Square {
    let value: Int
    private(set) var isMarked: Bool = false

    mutating func mark() {
        isMarked = true
    }
}

extension Square: NumericExpressible {
    static var zero: Int { .zero }
    var numericValue: Int { value }
}

struct Board {
    private(set) var rows: Dictionary<Int, Dictionary<Int, Square>>
    private(set) var hasBingo: Bool = false

    init(board: String) {
        rows = board.lines
            .map { line -> [Int: Square] in
                let numbers = line.components(separatedBy: .whitespacesAndNewlines)
                    .compactMap(Int.init)
                    .map { Square.init(value: $0) }
                return numbers.indexedDict()
            }
            .indexedDict()
        print(self)
    }

    mutating func mark(_ value: Int) {
        for x in (0..<rows.count) {
            for y in (0..<rows[x]!.count) {
                guard var square = rows[x]?[y] else { continue }
                if square.isMarked { continue }
                if square.value == value { square.mark() }
                rows[x]?[y] = square
            }
        }

        hasBingo = checkRows() || checkColumns()
    }

    private func checkRows() -> Bool {
        rows.first { $0.value.allSatisfy(\.value.isMarked)} != nil
    }

    private func checkColumns() -> Bool {
        for y in 0 ..< rows[0]!.count {
            if rows.compactMap ({ $0.value[y] }).allSatisfy(\.isMarked) { return true }
        }
        return false
    }

    func sumOfUnmarked() -> Int {
        rows.map {
            $0.value.reduce(0) { partialResult, indexAndRow in
                if indexAndRow.value.isMarked { return partialResult }
                return partialResult + indexAndRow.value.value
            }
        }.sum
    }
}

extension Board: CustomDebugStringConvertible {
    var debugDescription: String {
        var description = ""
        for y in 0 ..< rows.count {
            for x in 0 ..< rows[0]!.count {
                let square = rows[y]![x]!
                let value = square.value
                let string = value >= 10 ? " \(value)" : "  \(value)"
                description = description + string
            }
            description = description + "\n"
        }
        return description
    }
}

final class Day4: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        return 0
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return 0
    }
}
