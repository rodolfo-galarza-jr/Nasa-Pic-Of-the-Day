//
//  MultiNetworkManager.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/7/21.
//

import Foundation
import Combine

class MultiNetworkManager: ObservableObject {
    
    @Published var infos = [PhotoInfo]()
    private var subscriptions = Set<AnyCancellable>()
    
    init(){
        let times = 0..<10
        
        times.publisher
            .map { daysFromToday in
                API.createDate(daysFromToday: daysFromToday)
            }.map{ date in
                return API.createURL(for: date)
            }.flatMap{ (url) in
                return API.createPublisher(url: url)
            }.scan([]) { (partialValue, newValue) in
                return partialValue + [newValue]
            }
            .tryMap{ infos in
                infos.sorted { $0.formattedDate > $1.formattedDate }
            }
            .eraseToAnyPublisher()
            .catch { (error) in
                Just([PhotoInfo]())
            }
            .receive(on: RunLoop.main)
            .assign(to: \.infos, on: self)
            .store(in: &subscriptions)
    }
}
