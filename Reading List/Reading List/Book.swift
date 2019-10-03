//
//  Book.swift
//  Reading List
//
//  Created by Craig Swanson on 10/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    let title: String
    let reasonToRead: String
    var hasBeenRead: Bool = false
}
