//
//  Books.swift
//  Robateria
//
//  Created by Korbinian Baumer on 16.01.18.
//  Copyright © 2018 Korbinian Baumer. All rights reserved.
//

import Foundation

class Books {
    let title : String
    let x: Int
    let y: Int
    let z: Bool

    init(_ title: String,_ x: Int,_ y: Int,_ z: Bool) {
        self.title = title
        self.x = x
        self.y = y
        self.z = z
    }
}
