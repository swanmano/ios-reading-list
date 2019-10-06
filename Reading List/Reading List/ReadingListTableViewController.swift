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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            let readBooks = bookController.readBook
            let unreadBooks = bookController.unreadBook
        if indexPath.section == 0 {
            return readBooks[indexPath.row]
        } else {
            return unreadBooks[indexPath.row]
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
        bookController.books.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { fatalError() }
//            bookDetailVC.delete(self)
            bookDetailVC.bookController = bookController
            bookDetailVC.book = nil
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
        bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        tableView.reloadData()
    }
}

