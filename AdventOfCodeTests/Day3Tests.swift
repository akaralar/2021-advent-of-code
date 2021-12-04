//
//  Day3Tests.swift
//  Day3Tests
//

import XCTest

class Day3Tests: XCTestCase {
    let day = Day3()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1(
                """
                00100
                11110
                10110
                10111
                10101
                01111
                00111
                11100
                10000
                11001
                00010
                01010
                """
            ) as? Int,
            198
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2(
                """
                00100
                11110
                10110
                10111
                10101
                01111
                00111
                11100
                10000
                11001
                00010
                01010
                """
            ) as? Int,
            230
        )

    }

}
