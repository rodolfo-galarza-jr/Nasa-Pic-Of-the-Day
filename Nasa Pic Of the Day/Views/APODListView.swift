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
        List{
            ForEach(manager.infos) { info in
                ApodRow(photoInfo: info)
            }
        }
    }
}

struct APODListView_Previews: PreviewProvider {
    static var previews: some View {
        APODListView()
    }
}
