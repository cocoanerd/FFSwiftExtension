//
//  ViewController.swift
//  FFSwiftExtension
//
//  Created by cocoanerd on 03/24/2020.
//  Copyright (c) 2020 cocoanerd. All rights reserved.
//

import UIKit
import FFSwiftExtension

class ViewController: UIViewController {
    
    let dataSourceArray: [[String]] = [["UIButton","UIColor","UILabel","UIPasteBoard","UIView"],["UserDefaults","AttributedString","String"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ViewController"
        view.addSubview(tableView)
    }

    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.kScreenWidth, height:  UIScreen.kScreenHeight), style: .plain)
        tableView.backgroundColor = UIColor.randomColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var type: Int
        if indexPath.section == 0 {
            type = indexPath.row
        } else {
            type = (dataSourceArray.first?.count ?? 5) + indexPath.row
        }
        let detailVC = DetailViewController.init(type: type)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.kScreenWidth, height: 10))
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = dataSourceArray[indexPath.section][indexPath.row]
        return cell
    }
    
}
