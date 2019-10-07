//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Craig Swanson on 10/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var book: Book? {
        didSet {
            updateView()
        }
    }
    
    var delegate: BookTableViewCellDelegate?
    
    
    // MARK: Outlets
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    

    // MARK: Actions
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        var book = delegate?.toggleHasBeenRead(for: self)
        
        updateView()
    }
    
    // MARK: Methods
    private func updateView() {
        guard let book = book else { return }
        
        bookLabel.text = book.title
        if book.hasBeenRead {
            let buttonImage = UIImage(named: "checked")
            bookButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "unchecked")
            bookButton.setImage(buttonImage, for: .normal)
        }
    }
    
}

