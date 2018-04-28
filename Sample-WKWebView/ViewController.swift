//
//  ViewController.swift
//  Sample-WKWebView
//
//  Created by NishiokaKohei on 2018/04/27.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    private let webView: WKWebView

    // MARK: - Initializer

    init(_ frame: CGRect = .zero) {
        let configuration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: frame, configuration: configuration)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        let configuration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        super.init(coder: aDecoder)
    }

    // MARK: - Life cycle

    override func loadView() {
        super.loadView()
        webView.frame = UIScreen.main.bounds
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // loading web content
        let url =  URL(string: "https://developer.apple.com/documentation/webkit/wkwebview")!
        webView.load(URLRequest(url: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - WKUIDelegate

extension ViewController: WKUIDelegate {

}









