//
//  APODListView.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/7/21.
//

import SwiftUI

struct APODListView: View {
    @ObservedObject var manager = MultiNetworkManager()
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(manager.infos) { info in
                    NavigationLink(destination: APODDetailView(photoInfo: info, manager: manager)){
                        ApodRow(photoInfo: info)
                    }
                        .onAppear { // when we are on the last row load 10 more
                            if let index = self.manager.infos.firstIndex(where: { $0.id == info.id }),
                               index == self.manager.infos.count - 1 && self.manager.daysFromToday == self.manager.infos.count - 1 {
                                self.manager.getMoreData(for: 10)
                            }
                        }
                }

                ForEach(0..<15) { _ in
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 50)
                }
            }
            .navigationBarTitle("Pic of the Day")
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
    }
}
