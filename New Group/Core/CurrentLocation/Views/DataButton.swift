//
//  DataButton.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 22/05/23.
//

import SwiftUI

struct DataButton: View {
    func buttonPressedData() {
        print("button clicked")
    }
        
    var body: some View {
            Button (action: { buttonPressedData()
                
            }) {
                Image("Data")
            }
        }
    }


struct DataButton_Previews: PreviewProvider {
    static var previews: some View {
        DataButton()
    }
}
