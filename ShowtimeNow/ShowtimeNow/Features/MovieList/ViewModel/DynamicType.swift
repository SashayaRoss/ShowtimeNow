//
//  DynamicType.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 27/05/2023.
//

import Foundation

final class DynamicType<T> {
    public init() {}

    public var listeners: [(T) -> Void] = []

    public var value: T? {
        didSet {
            for listener in listeners {
                if let value = value {
                    listener(value)
                }
            }
        }
    }

    public func bind(listener: @escaping (T) -> Void) {
        listeners.append(listener)
        if let value = value {
            listener(value)
        }
    }
}

