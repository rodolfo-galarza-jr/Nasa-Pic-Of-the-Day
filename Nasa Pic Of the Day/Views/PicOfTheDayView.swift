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
        VStack(alignment: .leading, spacing: 10) {
            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
            }
            
            ScrollView{
                VStack{
                    Text(manager.photoInfo.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(manager.photoInfo.date)
                    Text(manager.photoInfo.description)
                }
            }.padding()

        }
        
    }
}

struct PicOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        PicOfTheDayView()
    }
}
