//
//  Day4.swift
//  AdventOfCode
//

import Foundation
import AOCToolbox

struct Square {
    let value: Int
    private(set) var isMarked: Bool = false

    mutating func mark() {
        isMarked = true
    }
}

extension Square: StringInitializable {
    init?(_ description: String) {
        if let value = Int(description) {
            self.value = value
        } else {
            return nil
        }
    }
}

extension Square: NumericExpressible {
    static var zero: Int { .zero }
    var numericValue: Int { value }
}

struct Board {
    private(set) var matrix: Matrix<Square>
    private(set) var hasBingo: Bool = false

    init(board: String) {
        matrix = Matrix(board, lineDelimiter: "\n", interItemDelimiter: .whitespacesAndNewlines)
    }

    mutating func mark(_ value: Int) {
        for y in (0..<matrix.capacity.height) {
            for x in (0..<matrix.capacity.width) {
                guard var square = matrix[x, y] else { continue }
                if square.isMarked { continue }
                if square.value == value { square.mark() }
                matrix[x, y] = square
            }
        }

        hasBingo = checkRows() || checkColumns()
    }

    private func checkRows() -> Bool {
        matrix.anyRowSatisfy(\.isMarked)
    }

    private func checkColumns() -> Bool {
        matrix.anyColumnSatisfy(\.isMarked)
    }

    func sumOfUnmarked() -> Int {
        matrix
            .elements { !$0.isMarked }
            .map(\.value)
            .sum
    }
}

extension Board: CustomDebugStringConvertible {
    var debugDescription: String {
        matrix.debugDescription
    }
}

final class Day4: Day {
    func part1(_ input: String) -> CustomStringConvertible {
        let inputs = input.rows(with: "\n\n")
        var (draws, boards) = (
            inputs[0].rows(with: ",").compactMap(Int.init),
            inputs[1...].map(Board.init(board:))
        )

        for draw in draws {
            for i in (0..<boards.count) {
                var board = boards[i]
                board.mark(draw)
                boards[i] = board
            }

            if let bingoBoard = boards.filter(\.hasBingo).first {
                return bingoBoard.sumOfUnmarked() * draw
            }
        }

        return 0
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let inputs = input.rows(with: "\n\n")
        var (draws, boards) = (
            inputs[0].rows(with: ",").compactMap(Int.init),
            inputs[1...].map(Board.init(board:))
        )

        var lastBingoBoard: Board? = nil
        for draw in draws {
            boardLoop: for i in (0..<boards.count) {
                var board = boards[i]
                if board.hasBingo { continue boardLoop }
                board.mark(draw)
                boards[i] = board
                if board.hasBingo { lastBingoBoard = board }
            }

            if boards.allSatisfy(\.hasBingo), let board = lastBingoBoard {
                return board.sumOfUnmarked() * draw
            }
        }

        return 0

    }
}
