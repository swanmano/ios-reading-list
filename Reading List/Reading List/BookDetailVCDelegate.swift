//
//  BookDetailVCDelegate.swift
//  Reading List
//
//  Created by Craig Swanson on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookDetailVCDelegate {
    func bookWasCreated(_ book: Book)
    func editExistingBook(_ bookIndex: Int, wasUpdated newBook: Book)
}
