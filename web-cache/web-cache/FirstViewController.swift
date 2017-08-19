//
//  FirstViewController.swift
//  web-cache
//
//  Created by Kevin Peng on 2017-08-19.
//  Copyright © 2017 Kevin Peng & Julian Nadeau. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var files : Array<URL> = []
    @IBOutlet weak var tableView: UITableView!;

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        files = Downloader.listFiles();
        tableView.reloadData();
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let testController = self.tabBarController?.viewControllers?[1] as? SecondViewController {
            testController.file = files[indexPath.row]
            self.tabBarController?.selectedIndex = 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        cell.textLabel?.text = files[indexPath.row].lastPathComponent
        return cell
    }

}

