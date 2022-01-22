//
//  EmojiModel.swift
//  EmojiModel
//
//  Created by Евгений Пашко on 01.11.2021.
//

struct EmojiModel: Codable {
    var symbol: String
    var name: String
    var description: String
    var usege: String
    
    init (symbol: String = "", name: String = "", description: String = "", usege: String = "") {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usege = usege
    }
}


extension EmojiModel {
    static var all: [EmojiModel] {
        return [
            EmojiModel(symbol: "😀", name: "Улыбка", description: "Улыбка с открытым ртом", usege: "Используйте, когда необходимо показать чувство радости"),
            EmojiModel(symbol: "🥳", name: "Праздник", description: "Праздничный смайлик", usege: "Используйте, когда необходимо показать чувство праздника"),
            EmojiModel(symbol: "👍", name: "Класс", description: "Поставить лайк", usege: "Используйте, когда необходимо поставить лайк"),
            EmojiModel(symbol: "👀", name: "Глаза", description: "Выразить любопытство", usege: "Используйте, когда необходимо показать любопытство"),
            EmojiModel(symbol: "⭐️", name: "Звезда", description: "Пятиконечная звезда", usege: "Используйте, когда необходимо показать звезду"),
        ]
    }
    
    static func loadDefaults() -> [EmojiModel] {
        return EmojiModel.all
    }
}
