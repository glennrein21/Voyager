//
//  CurrentLocationButton.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 21/05/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct CurrentLocationButton: View {
    
    @ObservedObject var location: LocationManager
    
    var body: some View {
        
        
        LocationButton(.currentLocation) {
            print("Clicked")
            location.goToUserLocation()
        }
        .foregroundColor(.black)
        .cornerRadius(8)
        .labelStyle(.iconOnly)
        .symbolVariant(.fill)
        .tint(.white)
        .shadow(color : .purple, radius: 4)
        .padding(.bottom)
        .frame(width: 200, height: 200)
        
        
        
        
        }
       
    }



    
struct CurrentLocationButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocationButton(location: LocationManager())
    }
}
