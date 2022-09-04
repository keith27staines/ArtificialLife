//
//  Node.swift
//  ArtificialLife
//
//  Created by Keith Staines on 04/09/2022.
//

struct Node: Identifiable, Hashable {
    let id: Int
    let bias: Float
}

extension Node: Comparable {
    static func < (lhs: Node, rhs: Node) -> Bool {
        lhs.id < rhs.id
    }
}
