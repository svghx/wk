//
//  ViewController.swift
//  WK
//
//  Created by SVGHX on 10/31/22.
//

import UIKit
import WebKit
import TinyConstraints

class ViewController: UIViewController {
    let headerHTML = "<header><meta name='viewport' content= 'width=device width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let source: String = "var meta = document.createElement('meta');" +
        "meta.name = 'viewport';" +
        "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
        "var head = document.getElementsByTagName('head')[0];" +
        "head.appendChild(meta);"
        
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        configuration.userContentController.addUserScript(script)
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.contentMode = .scaleToFill
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        webView.height(100)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "This label should position itself just below the loaded post"
        label.backgroundColor = .red
        view.addSubview(label)
        label.horizontalToSuperview(insets: .horizontal(10))
        label.topToBottom(of: webView, offset: 10)
        
        let instaString = """
        <iframe class="instagram-embed" src="https://instagram.com/p/BlNaCrZnkFu/embed/captioned" width='100%' height='100%' frameborder="0"></iframe>
        """
        
//        let instaString2 = """
//<iframe src="https://www.instagram.com/p/CKeOtofns1P/embed/captioned" width='100%' height='100%' frameborder="0"></iframe>
//"""
        
//        let fbString = """
//<iframe src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2FFederer%2Fposts%2F676273227199231&show_text=true&width=500" width="100%" height="100%" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowfullscreen="true" allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share"></iframe>
//"""
        
        webView.loadHTMLString(headerHTML + instaString, baseURL: nil)
        
    }


}


extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.isLoading == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                    if complete != nil {
                        webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                            if error == nil {
                                guard let height = height as? CGFloat else { return }
                                webView.frame.size.height = height
                                webView.removeConstraints(webView.constraints)
                                UIView.animate(withDuration: 0.3) {
                                    webView.height(height) //update webview height on finish loading page
                                    self.view.layoutIfNeeded()
                                }
                            }
                        })
                    }
                })
            }
        }
    }
}
