//
//  API.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/7/21.
//

import Foundation
import Combine


struct API {
    
    static func createFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static func createURL(for date: Date) -> URL {
        
        let formatter = createFormatter()
        let dateString = formatter.string(from: date)
        
        let url = URL(string: URLConstants.PodURL)!
        let fullURL = url.withQuery(["api_key" : URLConstants.key, "date": dateString])!
        
        return fullURL
    }
    
    static func createDate(daysFromToday: Int) -> Date {
        let today = Date()
        if let newDate = Calendar.current.date(byAdding: .day, value: -daysFromToday, to: today){
            return newDate
        }else{
            return  today
        }
    
    }
    static func createPublisher(url: URL) -> AnyPublisher<PhotoInfo, Never> {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PhotoInfo.self, decoder: JSONDecoder())
            .catch{ (error) in
                Just(PhotoInfo())
            }
            .eraseToAnyPublisher()
    }
}
