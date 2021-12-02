//
//  String+Parsing.swift
//  AdventOfCode
//
//  Created by ahmet.karalar on 02/12/2021.
//

import Foundation

extension String {
    var integers: [Int] { components(separatedBy: "\n").compactMap(Int.init) }
}
