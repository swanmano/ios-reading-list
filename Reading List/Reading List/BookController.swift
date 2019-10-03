//
//  BookController.swift
//  Reading List
//
//  Created by Craig Swanson on 10/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
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
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
