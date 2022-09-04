//
//  ActivationTests.swift
//  ArtificialLifeTests
//
//  Created by Keith Staines on 04/09/2022.
//

import XCTest
@testable import ArtificialLife

final class ActivationTests: XCTestCase {
    
    let huge: Float = Float.greatestFiniteMagnitude
    let accuracy = Float(0.00001)

    func test_sigmoid() {
        XCTAssertEqual(Activation.lg(0), 0.5)
        XCTAssertEqual(Activation.lg(huge), 1.0, accuracy: accuracy)
        XCTAssertEqual(Activation.lg(-huge), 0.0, accuracy: accuracy)
    }
    
    func test_tanh() {
        XCTAssertEqual(Activation.th(0), 0)
        XCTAssertEqual(Activation.th(huge), 1.0, accuracy: accuracy)
        XCTAssertEqual(Activation.th(-huge), -1.0, accuracy: accuracy)
    }
    
    func test_relu() {
        XCTAssertEqual(Activation.relu(0), 0)
        XCTAssertEqual(Activation.relu(huge), huge, accuracy: accuracy)
        XCTAssertEqual(Activation.relu(-huge), 0.0, accuracy: accuracy)
    }
    
    func test_identity() {
        XCTAssertEqual(Activation.i(0), 0)
        XCTAssertEqual(Activation.i(huge), huge, accuracy: accuracy)
        XCTAssertEqual(Activation.i(-huge), -huge, accuracy: accuracy)
    }
    
    func test_argMax() {
        let values: [Float] = [0.0,1.9,2.7,0.4]
        XCTAssertEqual(Activation.argMax(values), 2)
    }
    
    func test_softMax() {
        let values: [Float] = [0.0,1.9,2.7,0.4]
        let probabilities = Activation.softMax(values)
        let sum = probabilities.reduce(0) { sum, value in sum + value }
        XCTAssertEqual(sum, 1.0, accuracy: accuracy)
    }
    
}
