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
        let book = bookFor(indexPath: indexPath)
        cell.book = book

        return cell
    }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

    // The function takes the cell from the bookButtonHasBeenTapped in BookTableViewCell, gets the index path and calls updateHasBeenRead in order to toggle the value
extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
    }
    
    
}
