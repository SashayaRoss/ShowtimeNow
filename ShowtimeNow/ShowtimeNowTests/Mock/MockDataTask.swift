//
//  MockDataTask.swift
//  ShowtimeNowTests
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import Foundation

final class MockDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
