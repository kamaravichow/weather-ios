//
//  ContentView.swift
//  WeatherMan
//
//  Created by Aravind Chowdary Kamani on 29/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var weatherManager = WeatherManager()
    
    @State var weather : ResponseBody?
    
    
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(lat: location.latitude, long: location.longitude)
                                
                            } catch {
                                print("error getting weather: \(error)")
                            }
                        }
                }
                
            } else {
                if(locationManager.isLoading){
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
            
        }
        
        .preferredColorScheme(.dark)
        .background(Color(hue: 0.64, saturation: 1.0, brightness: 0.346))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
