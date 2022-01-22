//
//  DataManager.swift
//  DataManager
//
//  Created by Евгений Пашко on 01.11.2021.
//

import Foundation

class DataManager {
    var archiveURL: URL? {
        guard let documentDirctory = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask ).first else {
            return nil
        }
        
        return documentDirctory.appendingPathComponent("emojis").appendingPathExtension("plist")
    }
    
    func loadEmojis() -> [EmojiModel]? {
        guard let archiveURL = archiveURL else {
            return nil
        }
        
        guard let encodedEmoji = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        
        let decoder = PropertyListDecoder()
        
        return try? decoder.decode([EmojiModel].self, from: encodedEmoji)
    }
    
    func saveEmojis(_ emojis: [EmojiModel]) {
        let encoder = PropertyListEncoder()
        
        guard let encodedEmojis = try? encoder.encode(emojis) else {
            return
        }
        
        guard let archiveURL = archiveURL else {
            return
        }
        
        try? encodedEmojis.write(to: archiveURL, options: .noFileProtection)
    }
}
