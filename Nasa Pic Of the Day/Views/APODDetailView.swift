//
//  APODDetailView.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/12/21.
//

import SwiftUI

struct APODDetailView: View {
    
    let photoInfo: PhotoInfo
    
    init(photoInfo: PhotoInfo, manager: MultiNetworkManager){
        print("init detail for \(photoInfo.date)")
        self.photoInfo = photoInfo
        self.manager = manager
    }
    
    @ObservedObject var manager: MultiNetworkManager
    
    
    var body: some View {
        
        if photoInfo.image != nil {
            Image(uiImage: self.photoInfo.image!)
                .resizable()
                .scaledToFit()
        }else{
            Rectangle().fill(Color(.lightGray))
                .frame(height: 400)
        }
        
        ScrollView{
            VStack(alignment: .center, spacing: 10){
                Text(photoInfo.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text(photoInfo.description)
                    .multilineTextAlignment(.leading)
            }
        }.padding()
        .navigationBarTitle(Text(photoInfo.date), displayMode: .inline)
        .onAppear {
            self.manager.fetchImage(for: self.photoInfo)
        }
    }
}

struct APODDetailView_Previews: PreviewProvider {
    static var previews: some View {
        APODDetailView(photoInfo: PhotoInfo.init(), manager: MultiNetworkManager())
    }
}
