//
//  NodeInsertionTests.swift
//  ArtificialLifeTests
//
//  Created by Keith Staines on 05/09/2022.
//

import XCTest
@testable import ArtificialLife

final class NodeInsertionTests: XCTestCase {
    let idProvider = SequentialIdProvider()
    
    func test_node_insertion() {
        let genome = makeTrivialGenome(idProvider: idProvider, connectionWeight: 0.4)
        let newGenome = genome.insertingNode(existingConnectionIndex: 0, idProvider: idProvider)
        XCTAssertTrue(newGenome.id > genome.id)
        XCTAssertEqual(newGenome.nodes.count, 3)
        XCTAssertEqual(newGenome.connections.count, 3)
        XCTAssertFalse(newGenome.connections[0].isEnabled)
        XCTAssertTrue(newGenome.connections[1].isEnabled)
        XCTAssertTrue(newGenome.connections[2].isEnabled)
        XCTAssertEqual(newGenome.connections[1].weight, 0.4)
        XCTAssertEqual(newGenome.connections[2].weight, 1)
    }
}

extension Genome {
    
    func insertingNode(existingConnectionIndex: Int, idProvider: IdProvider) -> Genome {
        let existingConnection = connections[existingConnectionIndex]
        let newNode = Node(id: idProvider.next, bias: 0)
        let inputSideConnection = Connection(
            id: idProvider.next,
            inputNode: existingConnection.inputNode,
            outputNode: newNode.id,
            weight: existingConnection.weight,
            isEnabled: true)
        let outputSideConnection = Connection(
            id: idProvider.next,
            inputNode: newNode.id,
            outputNode: existingConnection.outputNode,
            weight: 1,
            isEnabled: true)
        var nodes = self.nodes
        nodes.append(newNode)
        var connections = self.connections
        connections[existingConnectionIndex].isEnabled = false
        connections.append(contentsOf: [inputSideConnection, outputSideConnection])
        
        return Genome(
            id: idProvider.next,
            nodes: nodes, connections: connections)
    }
}
