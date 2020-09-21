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
        
//        setNavigationBar()
    }
    
    @objc private func dismissViewCtr(){
        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
//    private func setNavigationBar(){
//        let height: CGFloat = 75
//        let navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
//        navbar.backgroundColor = UIColor.white
//        navbar.delegate = self
//
//        let navItem = UINavigationItem()
//        navItem.title = "Title"
//        navItem.leftBarButtonItem = UIBarButtonItem(title: "Left Button", style: .plain, target: self, action: nil)
//        navItem.rightBarButtonItem = UIBarButtonItem(title: "Right Button", style: .plain, target: self, action: nil)
//
//        navbar.items = [navItem]
//
//        view.addSubview(navbar)
//
//        view.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height))
//    }
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
