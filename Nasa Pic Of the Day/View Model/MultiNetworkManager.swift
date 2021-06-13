//
//  MultiNetworkManager.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/7/21.
//

import Foundation
import Combine
import SwiftUI

class MultiNetworkManager: ObservableObject {
    
    @Published var infos = [PhotoInfo]()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var daysFromToday: Int = 0
    
    init(){

        $daysFromToday
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
        
        getMoreData(for: 20)
    }
    
    
    func getMoreData(for times: Int) {
        for _ in 1..<times {
            self.daysFromToday += 1
        }
    }
    
    func fetchImage(for photoInfo: PhotoInfo){
        guard photoInfo.image == nil, let url = photoInfo.url else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error \(error.localizedDescription) on fetch image")
            }else if let data = data, let image = UIImage(data: data),
                     let index = self.infos.firstIndex(where: { $0.id == photoInfo.id}){
                DispatchQueue.main.async {
                    self.infos[index].image = image
                }
            }
        }
        
        task.resume()
    }
    
    
}
