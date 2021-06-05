//
//  PicOfTheDayView.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/5/21.
//

import SwiftUI

struct PicOfTheDayView: View {
    
    @ObservedObject var manager = NetworkManager()
    
    var body: some View {
        Text(manager.photoInfo.title)
    }
}

struct PicOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        PicOfTheDayView()
    }
}
