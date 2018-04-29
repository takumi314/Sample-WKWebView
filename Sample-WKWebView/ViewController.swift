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
        setupWebView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // NavigationController
        navigationController?.view.backgroundColor = .lightGray
        navigationItem.title = "Scene1"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }

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

// MARK: - WKNavigationDelegate

extension ViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation) {
        print("Start !")
        closeWebView()
        showIndicator()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation, withError error: Error) {
        print("Error !")
        closeIndicator()
        showWebView()
    }

    ///
    /// Webのロード完了後に実行される
    ///
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        print("Finided !")
        closeIndicator()
        showWebView()
    }

}

// MARK: - Private methods

extension ViewController {

    private func setupWebView() {
        let height = UIApplication.shared.statusBarFrame.height
            + navigationController!.navigationBar.frame.height
        let rect = CGRect(x: 0.0,
                          y: height,
                          width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height - height)
        webView.frame = rect
        webView.scrollView.bounces = false
        webView.isHidden = true

        webView.uiDelegate = self
        webView.navigationDelegate = self

        guard let nvc = self.navigationController else {
            view = webView
            return
        }

        nvc.view.addSubview(webView)
    }






    private func showWebView() {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.webView.isOpaque = false
                self.webView.isHidden = false
        })
    }

    private func closeWebView() {
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.webView.isOpaque = true
                self.webView.isHidden = true
        })
    }

}
