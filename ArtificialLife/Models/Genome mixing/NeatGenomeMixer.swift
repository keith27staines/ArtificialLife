//
//  Neat.swift
//  ArtificialLife
//
//  Created by Keith Staines on 04/09/2022.
//

import Foundation

class RandomParentPreferenceProvider: ParentPreferenceProvider {
    var preferFirst: Bool { Bool.random() }
}

class NeatGenomeMixer: GenomeMixer {
    
    let idProvider: IdProvider
    let parentPreferenceProvider: ParentPreferenceProvider
    
    func mix(_ g1: Genome, _ g2: Genome) -> Genome {
        guard g1 != g2 else { return g1 }
        let nodesSet = Set<Node>(g1.nodes + g2.nodes)
        let nodes = Array(nodesSet).sorted()
        let connectionsSet = Set<Connection>()
        let allConnections = Set<Connection>(g1.connections + g2.connections)
        var dictionary = [String: Connection?]()
        allConnections.forEach { connection in
            dictionary[connection.key()] = parentPreferenceProvider.preferFirst ? g1.connections.firstConnection(from: connection.inputNode, to: connection.outputNode) :
            g2.connections.firstConnection(from: connection.inputNode, to: connection.outputNode)
        }
        
        let connections = dictionary.compactMap { (key: String, value: Connection?) in
            value
        }.sorted()
        
        return Genome(
            id: idProvider.next,
            nodes: nodes,
            connections: connections)
    }
    
    init(idProvider: IdProvider, parentPreferenceProvider: ParentPreferenceProvider) {
        self.idProvider = idProvider
        self.parentPreferenceProvider = parentPreferenceProvider
    }
}

extension Connection {
    func key() -> String {
        func stringFromOptionalInt(_ int: Int?) -> String {
            guard let int = int else { return "nil" }
            return String(int)
        }
        return "\(stringFromOptionalInt(inputNode)):\(stringFromOptionalInt(outputNode))"
    }
}

extension Array where Element == Connection {
    
    fileprivate func firstConnection(from inputNode: Int?, to outputNode: Int?) -> Connection? {
        firstSensor(outputNode: outputNode) ??
        firstOutput(inputNode: inputNode) ??
        firstInternalConnection(from: inputNode, to: outputNode)
    }
    
    fileprivate func firstSensor(outputNode: Int?) -> Connection? {
        guard let outputNode = outputNode else { return nil }
        return self.first { connection in
            connection.inputNode == nil && connection.outputNode == outputNode
        }
    }
    
    fileprivate func firstOutput(inputNode: Int?) -> Connection? {
        guard let inputNode = inputNode else { return nil }
        return first { connection in
            connection.inputNode == inputNode && connection.outputNode == nil
        }
    }
    
    fileprivate func firstInternalConnection(from inputNode: Int?, to outputNode: Int?) -> Connection? {
        guard let inputNode = inputNode, let outputNode = outputNode else { return nil }
        return self.first { connection in
            connection.inputNode == inputNode && connection.outputNode == outputNode
        }
    }
}
