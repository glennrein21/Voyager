//
//  HomeView.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 20/05/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit
import SwiftUIX
import UIKit

struct HomeView: View {
    
    @StateObject private var location = LocationManager()
    @State private var showingSheetHistory = false
    @State private var showingSheetData = false
    
    //Gesture Sheet Properties
    @State private var offset : CGFloat = 0
    @State private var lastOffset : CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        
        ZStack{
            MapViewRepresentable(locationManager: location)
                .blur(radius: getBlurRadius())
                .ignoresSafeArea()
            
            VStack {
                ZStack{
                    Image("LinearGradientTop")
                        .ignoresSafeArea()
                        .padding(.top, -50)
                        .padding(.bottom, -45)
                    Text("VOYAGER")
                        .font(.custom("Futura-Bold", size: 24))
                        .blur(radius: getBlurRadius())
                    
                }
                HStack {
                    Spacer()
                    
                    VStack{
                        
                        
                        Spacer()
                        
                        CurrentLocationButton(location: location)
                            .blur(radius: getBlurRadius())
                        
                        
                        //                        HistoryButton()
                        
                        Button {
                            showingSheetHistory = true }
                    label: {
                        Image("History")
                    }
                    .blur(radius: getBlurRadius())
                    .sheet(isPresented: $showingSheetHistory) {
                        VStack {
                            
                            Image("CheckListFixPisan2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 300)
                                .padding(.bottom, -30)
                            
                            Text("HISTORY")
                                .font(.custom("Futura-Bold", size: 36))
                                .padding(.bottom, 0)
                            
                            
                            VisualEffectBlurView(blurStyle:.systemUltraThinMaterialDark, vibrancyStyle : .fill, content: {
                                Text("UI Design")
                                    .bold()
                                    .foregroundColor(.white)
                            })
                            
                            
                            .frame(maxWidth: .infinity, maxHeight: 220)
                            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke(lineWidth: 0.5).fill(LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)))
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            )
                            .shadow(color: Color.orange.opacity(0.3), radius: 20, x: 0 , y:10)
                            .padding()
                            
                            
                        }
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.medium])
                        
                    }
                        
                        Button {
                            showingSheetData = true
                        } label: {
                            Image("Data")
                        }
                        .blur(radius: getBlurRadius())
                        .sheet(isPresented: $showingSheetData) {
                            VStack {
                                
                                Image("StarDataFix3")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(width: 300, height: 300)
                                    .padding(.bottom, -40)
                                
                                
                                Text("DATA")
                                    .font(.custom("Futura-Bold", size: 36))
                                    .padding(.bottom, 0)
                                
                                
                            }
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium])
                        }
                    }
                    .padding(.horizontal, -40)
                    .padding(.vertical, 110)
                }
            }
            
            GeometryReader{proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                _ = proxy.frame(in: .global).width
                
                return AnyView(
                    
                    ZStack {
                        Rectangle()
                            .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 30))
                            .foregroundColor(.white)
                        
                        VStack{
                            Capsule()
                                .fill(Color.black)
                                .frame(width: 80, height: 4)
                                .padding(.top)
                            
                            Text("Achievement")
                                .font(.custom("Futura-Bold", size: 24))
                                .foregroundColor(.black)
                                .padding(.top, 5)
                            
                            
                            BottomSheetContent()
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                        .offset(y : height - 100)
                        .offset(y : -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                        .gesture(DragGesture().updating($gestureOffset, body:  {
                            value, out, _ in
                            
                            out = value.translation.height
                            onChange()
                        })
                            .onEnded({value in
                                
                                let maxHeight = height - 100
                                withAnimation{
                                    
                                    if -offset > 100 && -offset < maxHeight / 2 {
                                        offset = -(maxHeight / 3)
                                    }
                                    else if -offset > maxHeight / 2 {
                                        offset = -maxHeight
                                    }
                                    else
                                    {
                                        offset = 0
                                    }
                                }
                                
                                lastOffset = offset
                                
                            }))
                )
                
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
            
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            ) { success, error in
                if success {
                    print("Permission Granted")
                }
            }
        }
    }
    
    func onChange(){
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat{
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        return progress * 30
    }
    
    //    init() {
    //        for familyName in UIFont.familyNames {
    //            print(familyName)
    //
    //            for fontName in UIFont.fontNames(forFamilyName: familyName) {
    //
    //                print("--\(fontName)")
    //            }
    //        }
    //    }
    
    
    struct BottomSheetContent: View {
        @State private var  currentIndex: Int = 0
        @GestureState private var dragOffset: CGFloat = 0
        private let  images : [String] = ["Reward1fix", "Reward2fix", "Reward3fix"]
        var body: some View{
            VStack{
                NavigationStack{
                    VStack {
                        ZStack {
                            ForEach(0..<images.count, id: \.self) {
                                index in Image(images[index])
                                    .frame(width: 300, height: 500)
                                    .cornerRadius(25)
                                    .opacity(currentIndex == index ? 1.0 : 0.5)
                                    .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                                    .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y : 10)
                            }
                        }
                        
                        .gesture(DragGesture()
                            .onEnded({value in
                                let treshold: CGFloat = 50
                                if value.translation.width > treshold {
                                    withAnimation{
                                        currentIndex = max(0, currentIndex - 1)
                                    }
                                    
                                } else if value.translation.width < -treshold {
                                    withAnimation{ currentIndex = min(images.count - 1, currentIndex + 1)
                                    }
                                }
                            })
                        )
                    }
                }
            }
        }
        
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


