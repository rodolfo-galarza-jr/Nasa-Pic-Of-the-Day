//
//  PicOfTheDayView.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/5/21.
//

import SwiftUI

struct PicOfTheDayView: View {
    
    @ObservedObject var manager = NetworkManager()
    @State private var showChangeDate:Bool = false
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Button(action: {
                self.showChangeDate.toggle()
            }, label: {
                Image(systemName: "calendar")
                Text("Change Date")
            })
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .popover(isPresented: $showChangeDate ){
                ChangeDateView(manager: manager)
            }
            
            if manager.image != nil {
                Image(uiImage: self.manager.image!)
                    .resizable()
                    .scaledToFit()
            }else{
                Rectangle().fill(Color(.lightGray))
                    .frame(height: 400)
            }
            
            ScrollView{
                VStack(alignment: .center, spacing: 10){
                    Text(manager.photoInfo.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text(manager.photoInfo.date)
                    Text(manager.photoInfo.description)
                        .multilineTextAlignment(.leading)
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
