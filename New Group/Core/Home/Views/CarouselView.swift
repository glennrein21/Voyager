//
//  CarouselView.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 24/05/23.
//

import SwiftUI

struct CarouselView: View {
    @State private var  currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    private let  images : [String] = ["Reward1fix", "Reward2fix", "Reward3fix"]
    
    var body: some View {
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

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
