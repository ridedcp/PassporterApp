//
//  DetailView.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 13/5/22.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var city: CityModel
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25, longitude: 25), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State var showFullImage = false
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            ZStack {
                Text("")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                presentation.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.backward.circle.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .scaledToFit()
                                    .shadow(color: .gray, radius: 2, x: 0, y: 1)
                            }
                            .frame(width: Style.Spacing.spacingL, height: Style.Spacing.spacingL)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: shareCityImage) {
                                Image(systemName: "square.and.arrow.up.circle.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .scaledToFit()
                                    .shadow(color: .gray, radius: 2, x: 0, y: 1)
                            }
                            .frame(width: Style.Spacing.spacingL, height: Style.Spacing.spacingL)
                        }
                    }
                VStack {
                    Button(action: openImage) {
                        AsyncImage(url: URL(string: city.cover ?? "")) { image in
                            image.resizable()
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 15, x: 0, y: 10)
                                .scaledToFill()
                                .padding()
                                .frame(width: 300, height: 300)
                        } placeholder: {
                            Image("kite")
                                .resizable()
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 15, x: 0, y: 10)
                                .scaledToFill()
                                .padding()
                                .frame(width: 300, height: 300)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text(city.name ?? "")
                            .font(.title)
                        HStack {
                            Button(city.address ?? "") {
                                openAppleMapsWithCoordinates(lat: city.latitude ?? 0.0,
                                                             long: city.longitude ?? 0.0)
                            }
                            .font(.subheadline)
                            .foregroundColor(Color.green)
                            
                            Spacer()
                        }
                        
                        Map(coordinateRegion: $region)
                            .frame(minWidth: 300, maxWidth: 400, minHeight: 300, maxHeight: 400, alignment: .bottom)
                    }
                    .padding(EdgeInsets(top: 0, leading: Style.Spacing.spacingS, bottom: 0, trailing: Style.Spacing.spacingS))
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .navigationBarHidden(true)
        
        .onAppear {
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: city.latitude ?? 25, longitude: city.longitude ?? 25), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        }
        .fullScreenCover(isPresented: $showFullImage) {
            ModalView(cityImage: city.cover ?? "")
        }
    }
    
    func openImage() {
        self.showFullImage = true
    }
    
    func shareCityImage() {
        var imageToShare = UIImage()
        if let imageUrl = URL(string: city.cover ?? ""),
           let data = try? Data(contentsOf: imageUrl),
           let imageData = UIImage(data: data) {
            imageToShare = imageData
        } else {
            if let defaultImage = UIImage(named: "kite") {
                imageToShare = defaultImage
            }
        }
        let activity = UIActivityViewController(activityItems: [imageToShare as UIImage], applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let scene = scenes.first { $0.activationState == .foregroundActive }
        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.rootViewController?.present(activity, animated: true, completion: nil)
        }
    }
    
    func openAppleMapsWithCoordinates(lat: Double, long: Double) {
        let regionDistance: CLLocationDistance = 300
        let coordinates = CLLocationCoordinate2D(latitude: lat,
                                                 longitude: long)
        let regionSpan = MKCoordinateRegion(center: coordinates,
                                            latitudinalMeters: regionDistance,
                                            longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = city.name
        mapItem.openInMaps(launchOptions: options)
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(city: CityModel.init(name: "Valencia", cover: "kite", latitude: 40.4167047, longitude: -3.7035825, address: "Valencia, Community of Valencia"))
                .preferredColorScheme(.light)
            DetailView(city: CityModel.init(name: "Valencia", cover: "kite", latitude: 40.4167047, longitude: -3.7035825, address: "Valencia, Community of Valencia"))
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portraitUpsideDown)
            
        }
    }
}
