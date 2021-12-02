//
//  Day2Tests.swift
//  Day2Tests
//

import XCTest

class Day2Tests: XCTestCase {
    let day = Day2()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1(
            """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """,
            150
            )
        )
    }

    func testPart2() throws {
        XCTAssertEqual(
            day.part2(
            """
            forward 5
            down 5
            forward 8
            up 3
            down 8
            forward 2
            """,
            150
            )
        )

    }

}
