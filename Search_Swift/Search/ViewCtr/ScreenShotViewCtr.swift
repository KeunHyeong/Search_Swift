//
//  ScreenShotViewCtr.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class ScreenShotViewCtr: UIViewController, UINavigationBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    var info:SearchInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action:#selector(self.dismissViewCtr) )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
 
        tableView.register(UINib(nibName: "ScreenShotTableCell", bundle: nil), forCellReuseIdentifier: "ScreenShotTableCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc private func dismissViewCtr(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension ScreenShotViewCtr: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScreenShotTableCell", for: indexPath) as? ScreenShotTableCell else{
            return UITableViewCell()
        }
        cell.setViewDataObj(info: info)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenShotTableCell.cellHeight()
    }
}
