//
//  WebView.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/11/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @StateObject var viewModel = Dessert4MeViewModel()
    
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        if let url = URL(string: urlString) { // URL connecting to the web
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}


//#Preview {
//    WebView()
//}
