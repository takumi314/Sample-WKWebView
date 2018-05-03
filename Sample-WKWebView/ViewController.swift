//
//  ViewController.swift
//  Sample-WKWebView
//
//  Created by NishiokaKohei on 2018/04/27.
//  Copyright © 2018年 Takumi. All rights reserved.
//

import UIKit
import WebKit

extension String {
    static let APPLE_DOCUMENT_URL = "https://developer.apple.com/"
}

class ViewController: UIViewController {

    private let webView: WKWebView
    private let indicator: UIActivityIndicatorView

    // MARK: - Initializer

    init(_ frame: CGRect = .zero) {
        let configuration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: frame, configuration: configuration)
        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        let configuration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: configuration)
        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        super.init(coder: aDecoder)
    }

    // MARK: - Life cycle

    override func loadView() {
        super.loadView()
        setupWebView()
        setupIndicator()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // NavigationController
        navigationController?.view.backgroundColor = .lightGray
        navigationItem.title = "Scene1"
        if responds(to: #selector(reload)) {
            let item = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
            navigationItem.rightBarButtonItem = item
        }
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }

        // loading web content
        let url =  URL(string: .APPLE_DOCUMENT_URL)!
        webView.load(URLRequest(url: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(
            alongsideTransition: { (context) in
                // NavigationController

        }) { (context) in
            let height = UIApplication.shared.statusBarFrame.height
                + self.navigationController!.navigationBar.frame.height
            var rect = CGRect(x: 0.0,
                              y: height,
                              width: UIScreen.main.bounds.width,
                              height: UIScreen.main.bounds.height - height)
            if #available(iOS 11.0, *) {
                rect = CGRect(x: self.navigationController!.view.safeAreaInsets.left,
                              y: height,
                              width: UIScreen.main.bounds.width - 2 * self.navigationController!.view.safeAreaInsets.left,
                              height: UIScreen.main.bounds.height - height)
            } else {
                // Fallback on earlier versions
            }

            // NavigationController
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    self.webView.frame = rect
            })
        }
        super.willTransition(to: newCollection, with: coordinator)
    }

}

// MARK: - WKUIDelegate

extension ViewController: WKUIDelegate {

}

// MARK: - WKNavigationDelegate

extension ViewController: WKNavigationDelegate {

    ///
    /// Invoked when a main frame navigation starts.
    ///
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
        print("Start ...")
        showIndicator()
    }

    ///
    /// Invoked when an error occurs while starting to load data for the main frame.
    ///
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation, withError error: Error) {
        print("Error: \(error.localizedDescription)")
        closeIndicator()

        // dialog
        let alert = UIAlertController(title: L10n.AlertTitle.error, message: L10n.AlertMessage.error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.Alertaction.ok, style: .default))
        present(alert, animated: true)
    }

    ///
    /// Invoked when content starts arriving for the main frame.
    ///
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation) {
        print("Committing ...")
        closeWebView()
    }

    ///
    /// Invoked when an error occurs during a committed main frame navigation.
    ///
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation, withError error: Error) {
        print("Error: \(error.localizedDescription)")
        closeIndicator()
        showWebView()
    }

    ///
    /// Invoked when a main frame navigation completes.
    ///
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        print("Finished !")
        closeIndicator()
        showWebView()
    }

}

// MARK: - Private methods

extension ViewController {

    private func setupWebView() {
        let height = UIApplication.shared.statusBarFrame.height
            + self.navigationController!.navigationBar.frame.height
        var rect = CGRect(x: 0.0,
                          y: height,
                          width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height - height)
        if #available(iOS 11.0, *) {
            rect = CGRect(x: self.navigationController!.view.safeAreaInsets.left,
                          y: height,
                          width: UIScreen.main.bounds.width - 2 * self.navigationController!.view.safeAreaInsets.left,
                          height: UIScreen.main.bounds.height - height)
        } else {
            // Fallback on earlier versions
        }
        
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

    private func setupIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.activityIndicatorViewStyle = .whiteLarge

        // Note: 必ず制約を有効化する前に行う
        view.addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func reload() {
        showIndicator()
        closeWebView()
        webView.reload()
    }

    private func showIndicator() {
        indicator.isHidden = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
    }

    private func closeIndicator() {
        indicator.stopAnimating()
        indicator.isHidden = true
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
