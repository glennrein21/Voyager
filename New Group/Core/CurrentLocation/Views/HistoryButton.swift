//
//  HistoryButton.swift
//  Voyager
//
//  Created by Glenn Reinard Stanis on 22/05/23.
//

import SwiftUI

struct HistoryButton: View {
    @State private var showModel = false
    func buttonPressed() {
        print("button clicked")
    }
    var body: some View {
        Button (action: { showModel = true})
         {
            Image("History")
        }
    }
}

struct HistoryButton_Previews: PreviewProvider {
    static var previews: some View {
        HistoryButton()
    }
}
