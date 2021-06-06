//
//  NetworkManager.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/5/21.
//

import Foundation
import Combine
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var photoInfo = PhotoInfo()
    @Published var image: UIImage? = nil
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // fetch data
        let url = URL(string: URLConstants.PodURL)!
        let fullURL = url.withQuery(["api_key" : URLConstants.key])!
        
        
        URLSession.shared.dataTaskPublisher(for: fullURL)
            .map(\.data)
            .decode(type: PhotoInfo.self, decoder: JSONDecoder())
            .catch{ (error) in
                Just(PhotoInfo())
            }
            .receive(on: RunLoop.main)
            .assign(to: \.photoInfo, on: self)
            .store(in: &subscriptions)
        
        
        $photoInfo
            .filter{ $0.url != nil }
            .map{ photoInfo -> URL in
                return photoInfo.url!
            }.flatMap{ (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .catch{ error in
                        return Just(Data())
                    }
            }.map{ (out) -> UIImage? in
                UIImage(data: out)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
            .store(in: &subscriptions)
        
        
       // URLSession.shared.dataTaskPublisher(for: fullURL)
//            .sink(receiveCompletion: { (completion) in
//                switch completion {
//                case .finished:
//                    print("fetch completed")
//                case .failure(let failure):
//                    print("fetch complete with failure: \(failure.localizedDescription)")
//                }
//            }) { (data, response) in
//                if let description = String(data: data, encoding: .utf8){
//                    print("fetched new data \(description)")
//                }
//            }.store(in: &subscriptions)
    }
}
