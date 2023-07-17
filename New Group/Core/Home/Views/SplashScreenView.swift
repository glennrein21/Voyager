//
//  SplashScreenView.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 26/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack{
            if isActive {
                HomeView()
            } else {
                VStack {
                    Image("SplashScreenRevise")
                        .ignoresSafeArea()
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
