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
    
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView:UIView = UIView()
    
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
        webView.scrollView.isScrollEnabled = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(scrollView)
        scrollView.centerXToSuperview()
        scrollView.width(to: view)
        scrollView.topToSuperview(usingSafeArea: true)
        scrollView.bottomToSuperview()
        
        scrollView.addSubview(contentView)
        contentView.centerXToSuperview()
        contentView.width(to: scrollView)
        contentView.topToSuperview()
        contentView.bottomToSuperview()
        
        contentView.width(to: view, .none, multiplier: 1, offset: 0, relation: .equal, priority: .defaultHigh, isActive: true)
        contentView.height(to: view, .none, multiplier: 1, offset: 0, relation: .equal, priority: .defaultLow, isActive: true)

        
        let labelOne = UILabel()
        labelOne.numberOfLines = 0
        labelOne.font = .systemFont(ofSize: 19, weight: .medium)
        labelOne.textColor = .systemGray
        labelOne.text = "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. ######"
        
        let labelTwo = UILabel()
        labelTwo.numberOfLines = 0
        labelTwo.font = .systemFont(ofSize: 19, weight: .medium)
        labelTwo.textColor = .systemGray
        labelTwo.text = "@@@@@@ Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risusMorbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus"
        
        let stackView = UIStackView(arrangedSubviews: [labelOne, webView, labelTwo])
        stackView.axis = .vertical
        stackView.spacing = 15
        contentView.addSubview(stackView)
        stackView.edgesToSuperview()
        
        //initial height would be smaller like in this case
        //what's needed is that after the post is loaded the height should adjust accordingly
        webView.height(100)
        

        //feel free to try below sources
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
