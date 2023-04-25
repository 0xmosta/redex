//
//  WebView.swift
//  redex
//
//  Created by mosta on 25/04/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        uiView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "www.google.com")!))
    }
}
