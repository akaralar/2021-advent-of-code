//
//  Day5Tests.swift
//  Day5Tests
//

import XCTest

class Day5Tests: XCTestCase {
    let day = Day5()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1(
                """
                0,9 -> 5,9
                8,0 -> 0,8
                9,4 -> 3,4
                2,2 -> 2,1
                7,0 -> 7,4
                6,4 -> 2,0
                0,9 -> 2,9
                3,4 -> 1,4
                0,0 -> 8,8
                5,5 -> 8,2
                """
            ) as? Int,
            5
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2(
                """
                0,9 -> 5,9
                8,0 -> 0,8
                9,4 -> 3,4
                2,2 -> 2,1
                7,0 -> 7,4
                6,4 -> 2,0
                0,9 -> 2,9
                3,4 -> 1,4
                0,0 -> 8,8
                5,5 -> 8,2
                """
            ) as? Int,
            12
        )
    }
}
