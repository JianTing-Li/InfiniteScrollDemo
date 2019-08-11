//
//  InfinitScroll2Controller.swift
//  InfiniteScrollingDemo
//
//  Created by Jian Ting Li on 8/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class InfinitScroll2Controller: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var numArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
    var limit = 20
    var total = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
        tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension InfinitScroll2Controller: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.testLabel.text = "Item \(numArr[indexPath.row])"
        return cell
    }
    
    // Infinite Scrolling setup here!
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == numArr.count - 1 {  // we are at the last cell loaded
            // check if we have all data, if so hit the api recall
            if numArr.count <= total {
                var index = numArr.count
                limit = index + 20
                while index < limit {
                    numArr.append(index)
                    index += 1
                }
                // we want to reload tableview about 1 second delay because we don't want the system to make massive API calls
                perform(#selector(reloadTableView), with: nil, afterDelay: 1.0)
            }
        }
    }
    
    @objc private func reloadTableView() {
        tableView.reloadData()
    }
}
