//
//  WebViewViewController.swift
//  OnBoardingReusableViews
//
//  Created by Sejal Khanna on 08/06/22.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    private var WebView = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration())

    override func viewDidLoad() {
        super.viewDidLoad()
        WebView.uiDelegate = self

        if let url = URL(string: "https://onebanc.ai") {
            let request = URLRequest(url: url)
            WebView.load(request)
        }
        self.WebView.allowsBackForwardNavigationGestures = true
        WebView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
           self.WebView.frame   = CGRect(x: 0, y: 0, width: self.view.frame.width,
           height: self.view.frame.height - 100)
           }

    override func loadView() {
        self.view = WebView
    }
    
}
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
