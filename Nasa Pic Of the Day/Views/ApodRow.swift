//
//  ApodRow.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/7/21.
//

import SwiftUI

struct ApodRow: View {
    
    let photoInfo: PhotoInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(photoInfo.date)
            Text(photoInfo.title)
        }
    }
}

struct ApodRow_Previews: PreviewProvider {
    static var previews: some View {
        ApodRow(photoInfo: PhotoInfo.init())
    }
}
