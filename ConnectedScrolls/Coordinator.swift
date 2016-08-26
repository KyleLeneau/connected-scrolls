//
//  Coordinator.swift
//  ConnectedScrolls
//
//  Created by Kyle LeNeau on 8/25/16.
//  Copyright © 2016 Kyle LeNeau. All rights reserved.
//

import Foundation

public protocol Coordinator: class {
    func start()
}

public protocol ComposableCoordinator: Coordinator {
    var childCoordinators: [Coordinator] { get set }
}

extension ComposableCoordinator {
    public func findChildCoordinator<T>(type: T.Type) -> T? {
        return childCoordinators.filter({ (coordinator) -> Bool in
            return coordinator is T
        }).first as? T
    }
    
    public func removeChildCoordinator<T:Coordinator>(coordinator:T) -> T? {
        if let  potentialIndex = childCoordinators.index(where: { $0 is T }) {
            let index = Int(potentialIndex)
            childCoordinators.remove(at: index)
        }
        
        return coordinator
    }
}
