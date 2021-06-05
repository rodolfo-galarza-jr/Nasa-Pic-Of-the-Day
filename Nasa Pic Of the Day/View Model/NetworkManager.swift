//
//  NetworkManager.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/5/21.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // fetch data
        let url = URL(string: URLConstants.PodURL)!
        let fullURL = url.withQuery(["api_key" : URLConstants.key])!
        
        
        URLSession.shared.dataTaskPublisher(for: fullURL)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("fetch completed")
                case .failure(let failure):
                    print("fetch complete with failure: \(failure.localizedDescription)")
                }
            }) { (data, response) in
                if let description = String(data: data, encoding: .utf8){
                    print("fetched new data \(description)")
                }
            }.store(in: &subscriptions)
    }
}
