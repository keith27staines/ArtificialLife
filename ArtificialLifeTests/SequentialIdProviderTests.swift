//
//  SequentialIdProviderTests.swift
//  ArtificialLifeTests
//
//  Created by Keith Staines on 04/09/2022.
//

import XCTest
@testable import ArtificialLife

final class SequentialIdProviderTests: XCTestCase {

    func test_IdsFollowSequence() {
        let sut = SequentialIdProvider()
        (1...1000).forEach { expectedId in
            XCTAssertEqual(sut.next, expectedId)
        }
    }

}
