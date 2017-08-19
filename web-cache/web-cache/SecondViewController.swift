//
//  SecondViewController.swift
//  web-cache
//
//  Created by Kevin Peng on 2017-08-19.
//  Copyright © 2017 Kevin Peng & Julian Nadeau. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!;
    @IBOutlet weak var urlBox: UITextField!;
    var file: URL? = nil;

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFile(url: file!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        urlBox.text = webView.request?.url?.absoluteString
    }
    
    func loadFile(url: URL) {
        do {
            let contents =  try String(contentsOf: file!, encoding: .ascii)
            let baseUrl = URL(fileURLWithPath: (file?.absoluteString)!)
            webView.loadHTMLString(contents, baseURL: baseUrl)
        }
        catch {
            print ("File HTML error")
        }
    }
    
    func loadURL(url: URL) {
        webView.loadRequest(URLRequest(url: url))
    }
    
    @IBAction func downloadButtonWasPressed(sender: UIButton) {
        let url = URL(string: self.urlBox.text!);
        Downloader.downloadFile(url: url! as NSURL)
    }
    
    @IBAction func goButtonWasPressed(sender: UIButton) {
        let url = URL(string: self.urlBox.text!);
        loadURL(url: url!);
    }
}

