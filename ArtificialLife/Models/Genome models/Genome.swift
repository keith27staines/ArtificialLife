//
//  Genome.swift
//  ArtificialLife
//
//  Created by Keith Staines on 04/09/2022.
//

import Foundation

struct Genome: Identifiable {
    let id: Int
    let nodes: [Node]
    let connections: [Connection]
}

extension Genome: Hashable, Equatable {
    static func == (lhs: Genome, rhs: Genome) -> Bool {
        lhs.id == rhs.id
    }
}

