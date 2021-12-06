//
//  Day6Tests.swift
//  Day6Tests
//

import XCTest

class Day6Tests: XCTestCase {
    let day = Day6()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1(
                """
                3,4,3,1,2
                """
            ) as? Int,
            5934
        )
    }

    func testPart2() throws {
        debugPrint(day.part2(""))
    }

}
