//
//  GenomeFactories.swift
//  ArtificialLifeTests
//
//  Created by Keith Staines on 05/09/2022.
//

import XCTest
@testable import ArtificialLife

func makeTrivialGenome(
    idProvider: IdProvider,
    connectionWeight: Float = 0) -> Genome {
    let inputNode = Node(id: idProvider.next)
    let outputNode = Node(id: idProvider.next)
    let connection = Connection(
        id: idProvider.next,
        inputNode: inputNode.id,
        outputNode: outputNode.id,
        weight: connectionWeight,
        isEnabled: true)
    let genome = Genome(
        id: idProvider.next,
        nodes: [inputNode, outputNode],
        connections: [connection])
    XCTAssertEqual(genome.nodes.count, 2)
    XCTAssertEqual(genome.connections.count, 1)
    XCTAssertEqual(genome.connections[0].weight, connectionWeight)
    return genome
}
