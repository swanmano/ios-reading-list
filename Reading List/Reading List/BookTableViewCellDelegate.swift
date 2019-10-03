//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Craig Swanson on 10/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
