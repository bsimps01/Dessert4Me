//
//  LoadingView.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/11/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView("Loading...")
            Text("Please wait")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.8)) // Semi-transparent white background
        .foregroundColor(.black)
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    LoadingView()
}
