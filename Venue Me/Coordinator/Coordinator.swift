//
//  Coordinator.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 15/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import UIKit

protocol Coordinator {
    var window: UIWindow { get set }
    init(window: UIWindow)
    func start()
}
