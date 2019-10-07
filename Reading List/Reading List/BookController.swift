//
//  BookController.swift
//  Reading List
//
//  Created by Craig Swanson on 10/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: Properties
    var books: [Book] = []
    var readBook: [Book] {
        books.filter({$0.hasBeenRead == true})
    }
    var unreadBook: [Book] {
        books.filter({$0.hasBeenRead == false})
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: Saving and loading to/from property list
    private var readingListURL: URL? {
        let filemanager = FileManager.default
        guard let documents = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return nil }
        
        // /Users/craigswanson/Documents
        return documents.appendingPathComponent("ReadingList.plist")
        
    }
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let filemanager = FileManager.default
        guard let url = readingListURL,
            filemanager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    // MARK: Methods
    func create(bookTitle title: String, reasonToRead reason: String) -> Book {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func delete(_ book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    // deleted the return of type Book
    func updateHasBeenRead(for book: Book) {
        var book = book
        book.hasBeenRead.toggle()
        saveToPersistentStore()
 //       return book
    }
    
    // TODO: create a working editBook function
    func editBook(for book: Book) -> Book {
        
        saveToPersistentStore()
        return book
    }
}
