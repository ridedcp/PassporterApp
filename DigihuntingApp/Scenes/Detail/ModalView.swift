//
//  ModalView.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 14/5/22.
//

import SwiftUI

struct ModalView: View {
    let cityImage: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: cityImage)) { image in
                image.resizable()
            } placeholder: {
                Image("kite")
                    .resizable()
            }
            VStack {
                Spacer()
                Text(Constants.tapAnywhereTitle)
                    .font(.title3)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1, x: 0, y: 1)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(cityImage: "kite")
    }
}
