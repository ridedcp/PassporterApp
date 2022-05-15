//
//  TabBarView.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 15/5/22.
//

import SwiftUI

struct TabBarView: View {
    var city: CityModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            DetailView(city: city)
                .tabItem {
                    Text(Constants.listTitle)
                    Image(systemName: "rectangle.grid.2x2")
                }
                .tag(0)
            UserView()
                .tabItem {
                    Text(Constants.userTitle)
                    Image(systemName: "person")
                }
                .tag(1)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(city: CityModel.init(name: "Valencia", cover: "kite", latitude: 40.4167047, longitude: -3.7035825, address: "Valencia, Community of Valencia"))
    }
}
