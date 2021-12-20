//
//  Dictionary+Helpers.swift
//  AOCToolbox
//
//  Created by ahmet.karalar on 20/12/2021.
//

import Foundation

public extension Dictionary where Value: Hashable {
    func swappingKeysValues() -> Dictionary<Value, Key> {
        return .init(map { ($0.value, $0.key) }) { $1 }
    }
}
