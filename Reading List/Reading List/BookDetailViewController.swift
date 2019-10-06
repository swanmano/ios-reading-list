//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Craig Swanson on 10/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: Properties
    var bookController: BookController?
    var book: Book?
    
    // MARK: Outlets
    @IBOutlet weak var bookTitleText: UITextField!
    @IBOutlet weak var reasonToReadText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()

    }
    

    // MARK: Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if book == nil {
            guard let title = bookTitleText.text, !title.isEmpty,
                let reasonToRead = reasonToReadText.text, !reasonToRead.isEmpty else { return }
            bookController?.create(bookTitle: title, reasonToRead: reasonToRead)
            self.navigationController?.popViewController(animated: true)
        } else {
            guard let title = bookTitleText.text, !title.isEmpty,
                let reasonToRead = reasonToReadText.text, !reasonToRead.isEmpty else { return }
                let book = Book(title: title, reasonToRead: reasonToRead)
            bookController?.editBook(for: book)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Methods
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleText.text = book.title
        reasonToReadText.text = book.reasonToRead
        self.title = book.title
    }
    
    
}
