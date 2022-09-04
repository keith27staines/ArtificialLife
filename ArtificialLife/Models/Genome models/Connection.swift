//
//  Connection.swift
//  ArtificialLife
//
//  Created by Keith Staines on 04/09/2022.
//

import Foundation

struct Connection: Identifiable {
    let id: Int
    let inputNode: Int?
    let outputNode: Int?
    let weight: Float
    let isEnabled: Bool
}

extension Connection: Hashable {}

extension Connection: Comparable {
    static func < (lhs: Connection, rhs: Connection) -> Bool {
        lhs.id < rhs.id
    }
}


