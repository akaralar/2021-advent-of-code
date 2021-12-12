//
//  Day7Tests.swift
//  Day7Tests
//

import XCTest

class Day7Tests: XCTestCase {
    let day = Day7()

    func testPart1() throws {
        XCTAssertEqual(
            day.part1(
                """
                16,1,2,0,4,2,7,1,2,14
                """
            ) as? Int,
            37
        )
    }

    func testPart2() throws {
        debugPrint(day.part2(""))
    }

}
