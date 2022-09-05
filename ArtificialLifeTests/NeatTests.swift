//
//  NeatTests.swift
//  ArtificialLifeTests
//
//  Created by Keith Staines on 04/09/2022.
//

import XCTest
@testable import ArtificialLife

final class NeatTests: XCTestCase {
    
    let idProvider = SequentialIdProvider()
    
    func test_neat_withIdenticalTrivialGenomes() {
        let g = makeTrivialGenome(idProvider: idProvider)
        let sut = makeSUT()
        let child = sut.mix(g, g)
        XCTAssertEqual(child, g)
    }
    
    func test_neat_withGenomeswithIdenticalNodesAndConnections() {
        let genomes = makeDifferentGenomeswithIdenticalNodesAndConnection()
        let sut = makeSUT()
        let child = sut.mix(genomes.0, genomes.1)
        XCTAssertNotEqual(genomes.0, child)
        XCTAssertEqual(genomes.0.nodes, child.nodes)
        XCTAssertEqual(genomes.0.connections, child.connections)
    }
    
    func test_neat_withTrivialGenomesDifferingByConnection_whenFirstParentIsPreferred() {
        let genomes = makeDifferentGenomeswithIdenticalNodesButDifferentConnection()
        let sut = makeSUT(AlwaysChooseFirstParent())
        let child = sut.mix(genomes.0, genomes.1)
        XCTAssertEqual(child.connections[0], genomes.0.connections[0])
    }
    
    func test_neat_withTrivialGenomesDifferingByConnection_whenSecondParentIsPreferred() {
        let genomes = makeDifferentGenomeswithIdenticalNodesButDifferentConnection()
        let sut = makeSUT(NeverChooseFirstParent())
        let child = sut.mix(genomes.0, genomes.1)
        XCTAssertEqual(child.connections[0], genomes.1.connections[0])
    }
    
    func test_neat_withTwoAndThreeNodeParents() {
        let genomes = makeTrivialTwoAndThreeNodeGenomes(idProvider: idProvider)
        let sut = makeSUT()
        let child = sut.mix(genomes.0, genomes.1)
        XCTAssertEqual(child.nodes.count, 3)
    }

}

extension NeatTests {
    
    func makeSUT(_ parentPreferenceProvider: ParentPreferenceProvider = AlwaysChooseFirstParent()) -> NeatGenomeMixer {
        NeatGenomeMixer(idProvider: idProvider, parentPreferenceProvider: parentPreferenceProvider)
    }
    
    func makeDifferentGenomeswithIdenticalNodesButDifferentConnection() -> (Genome, Genome) {
        let g1 = makeTrivialGenome(idProvider: idProvider)
        let nodes2 = g1.nodes
        let differentConnection = Connection(
            id: idProvider.next,
            inputNode: nodes2[0].id,
            outputNode: nodes2[1].id,
            weight: -1,
            isEnabled: true)
        let g2 = Genome(id: idProvider.next, nodes: g1.nodes, connections: [differentConnection])
        XCTAssertEqual(g1.nodes, g2.nodes)
        XCTAssertNotEqual(g1.connections, g2.connections)
        return (g1, g2)
    }
    
    func makeDifferentGenomeswithIdenticalNodesAndConnection() -> (Genome, Genome) {
        let g1 = makeTrivialGenome(idProvider: idProvider)
        let g2 = Genome(id: idProvider.next, nodes: g1.nodes, connections: g1.connections)
        XCTAssertEqual(g1.nodes, g2.nodes)
        XCTAssertEqual(g1.connections, g2.connections)
        return (g1, g2)
    }
    
    func makeTrivialGenome(idProvider: IdProvider) -> Genome {
        let sensorNode = Node(id: idProvider.next)
        let outputNode = Node(id: idProvider.next)
        let connection = Connection(
            id: idProvider.next,
            inputNode: sensorNode.id,
            outputNode: outputNode.id,
            weight: 0,
            isEnabled: true)
        return makeGenome(
            idProvider.next, [sensorNode, outputNode], [connection])
    }
    
    func makeTrivialTwoAndThreeNodeGenomes(idProvider: IdProvider) -> (Genome,Genome) {
        let g1 = makeTrivialGenome(idProvider: idProvider)
        var nodes = g1.nodes
        nodes.append(Node(id: idProvider.next))
        let g2 = Genome(
            id: idProvider.next,
            nodes: nodes,
            connections: g1.connections)
        return (g1,g2)
    }
    
    func makeGenome(_ id: Int, _ nodes: [Node], _ connections: [Connection]) -> Genome {
        Genome(id: id,
               nodes: nodes,
               connections: connections
        )
    }
}

class AlwaysChooseFirstParent: ParentPreferenceProvider {
    var preferFirst = true
}

class NeverChooseFirstParent: ParentPreferenceProvider {
    var preferFirst = false
}


