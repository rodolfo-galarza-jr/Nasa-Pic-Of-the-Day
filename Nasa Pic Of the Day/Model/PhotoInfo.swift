//
//  PhotoInfo.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/5/21.
//

import Foundation

struct PhotoInfo : Codable{
    var title: String
    var description: String
    var url: URL?
    var copyright: String?
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try? valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
        self.date = try valueContainer.decode(String.self, forKey: CodingKeys.date)
    }
    
    init(){
        self.description = "TEST"
        self.title = "Title"
        self.date = ""
    }
}
