//
//  ChangeDateView.swift
//  Nasa Pic Of the Day
//
//  Created by Rodolfo Galarza Jr on 6/5/21.
//

import SwiftUI

struct ChangeDateView: View {
    
    @State private var date = Date()
    
    @ObservedObject var manager: NetworkManager
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Text("Select a Date")
                .font(.headline)
            DatePicker(selection: $date, in: ...Date()){
            }.labelsHidden()
            
            
            Button(action: {
                self.manager.date = self.date
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            })
        }
    }
}

struct ChangeDateView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeDateView(manager: NetworkManager())
    }
}
