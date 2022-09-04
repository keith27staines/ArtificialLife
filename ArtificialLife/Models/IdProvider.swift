//
//  IdProvider.swift
//  ArtificialLife
//
//  Created by Keith Staines on 04/09/2022.
//

import Foundation

protocol IdProvider {
    var next: Int { get }
}

class SequentialIdProvider: IdProvider {
    
    private var last: Int = 0
    
    var next: Int {
        last += 1
        return last
    }
}
