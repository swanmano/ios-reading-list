//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Craig Swanson on 10/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    // MARK: Properties
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return bookController.readBook.count
        } else {
            return bookController.unreadBook.count
        }
    }
    
    // Function separates the two sections of "Read Books" and "Unread Books", creates an array for each and then returns the correck book based on the indexpath.row
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBook[indexPath.row]
        } else {
            return bookController.unreadBook[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { fatalError() }
        cell.delegate = self
        let book = bookFor(indexPath: indexPath)
        cell.book = book

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let book = bookFor(indexPath: indexPath)
        bookController.delete(book)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { fatalError() }
            bookDetailVC.delegate = self
            bookDetailVC.bookController = bookController
            bookDetailVC.book = nil
            tableView.reloadData()
            bookController.saveToPersistentStore()
            
        } else if segue.identifier == "EditBookSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.book = bookController.books[indexPath.row]
            }
        }
    }

    
}

    // The function takes the cell from the bookButtonHasBeenTapped in BookTableViewCell, gets the index path and calls updateHasBeenRead in order to toggle the value
extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let newBook = bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        var book = bookFor(indexPath: indexPath)
        book.hasBeenRead = newBook.hasBeenRead
        tableView.reloadData()
    }
}

extension ReadingListTableViewController: BookDetailVCDelegate {
    func bookWasCreated(_ book: Book) {
        bookController.create(bookTitle: book.title, reasonToRead: book.reasonToRead)
        tableView.reloadData()
    }
    
    func editExistingBook(_ currentBook: Book, wasUpdated newBook: Book) {
        bookController.editBook(currentBook, newBook)
        tableView.reloadData()
    }
    
}

