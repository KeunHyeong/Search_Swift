//
//  SearchDetailVewCtr.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class SearchDetailVewCtr: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let typeList = ["header","release","collection","description","provider","size","category","age","copyright"]
    var selectIdx : IndexPath = IndexPath(row: 0, section: 0)
    var cellHeight : CGFloat = 0.0
    
    var info:SearchInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let backBarButtonItem = UIBarButtonItem(title: "You back button title here", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backBarButtonItem
//        self.navigationItem.title = "gkjsdjfkskjd"
        
        tableView.register(UINib(nibName: "SearchResultHeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib(nibName: "DetailTableCell", bundle: nil), forCellReuseIdentifier: "DetailTableCell")
        tableView.register(UINib(nibName: "DesDropTableCell", bundle: nil), forCellReuseIdentifier: "DesDropTableCell")
        tableView.register(UINib(nibName: "ReleaseDropCell", bundle: nil), forCellReuseIdentifier: "ReleaseDropCell")
        tableView.register(UINib(nibName: "ProviderCell", bundle: nil), forCellReuseIdentifier: "ProviderCell")
        tableView.register(UINib(nibName: "DetailCommonCell", bundle: nil), forCellReuseIdentifier: "DetailCommonCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavi()
//        naviImage.isHidden = true
    }
    
    private func setNavi(){
        let naviImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        naviImage.contentMode = .scaleAspectFit
        naviImage.layer.masksToBounds = true
        naviImage.layer.cornerRadius = 9
        naviImage.layer.borderWidth = 0.5
        naviImage.layer.borderColor = UIColor.lightGray.cgColor
        naviImage.load(url: self.info!.artworkUrl60!)
        self.navigationItem.titleView = naviImage
    }
}

extension SearchDetailVewCtr : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.y > 40 { //screen -> down
            self.navigationItem.titleView?.isHidden = true
        } else { //screen -> up
            self.navigationItem.titleView?.isHidden = false
            // swipes from bottom to top of screen -> up
        }
    }
}

extension SearchDetailVewCtr : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if typeList[indexPath.row] == "collection"{
            let st = UIStoryboard.init(name: "ScreenShotViewCtr", bundle: nil)
            guard let vc = st.instantiateViewController(withIdentifier: "ScreenShotViewCtr") as? ScreenShotViewCtr else{
                return
            }
            vc.info = self.info
            self.present(vc, animated: true, completion: nil)
            
        } else if typeList[indexPath.row] == "description" ||
                  typeList[indexPath.row] == "release" ||
                  typeList[indexPath.row] == "age"{
            selectIdx = indexPath
            tableView.beginUpdates()
            tableView.reloadRows(at: [selectIdx], with: .none)
            tableView.endUpdates()
        }
    }
}

extension SearchDetailVewCtr : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if typeList[indexPath.row] == "header" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? SearchResultHeaderCell else{
                 return UITableViewCell()
             }
             cell.setViewDataObj(info: self.info!)
             return cell
            
        }else if typeList[indexPath.row] == "collection"{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCell", for: indexPath) as? DetailTableCell else{
                return UITableViewCell()
            }
            cell.setViewDataObj(info: self.info!)
            return cell
            
        } else if typeList[indexPath.row] == "description"{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DesDropTableCell", for: indexPath) as?  DesDropTableCell else{
                return UITableViewCell()
            }
            cell.setViewDataObj(info: self.info!)
            cell.animate()
            cellHeight = cell.cellHeight()
            return cell
            
        } else if typeList[indexPath.row] == "provider"{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderCell", for: indexPath) as? ProviderCell else {
                return UITableViewCell()
            }
            cell.setViewDataObj(info: self.info!)
            return cell
            
        } else if typeList[indexPath.row] == "release"{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseDropCell", for: indexPath) as? ReleaseDropCell else {
                return UITableViewCell()
            }
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommonCell", for: indexPath) as?  DetailCommonCell else{
                return UITableViewCell()
            }
            
            if typeList[indexPath.row] == "age" {
                cell.setViewDataObj(type:"연령 등급",info: self.info!)
            }else if typeList[indexPath.row] == "size"{
                cell.setViewDataObj(type: "크기", info: self.info!)
            }else if typeList[indexPath.row] == "copyright" {
                cell.setViewDataObj(type: "저작권", info: self.info!)
            }else if typeList[indexPath.row] == "category"{
                cell.setViewDataObj(type: "카테고리", info: self.info!)
            }
//            cell.animate()
            cellHeight = cell.cellHeight()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if typeList[indexPath.row] == "header" {
            return SearchResultHeaderCell.cellHeight()
        }else if typeList[indexPath.row] == "collection" {
            return DetailTableCell.cellHeight()
        }else if typeList[indexPath.row] == "description"{
            if selectIdx == indexPath {
                return cellHeight + 100.0
            }
            return 200.0
        }else if typeList[indexPath.row] == "release"{
            
        } else if typeList[indexPath.row] == "provider"{
            return ProviderCell.cellHeight()
        } else if typeList[indexPath.row] == "age" ||
                  typeList[indexPath.row] == "size" ||
                  typeList[indexPath.row] == "copyright" ||
                  typeList[indexPath.row] == "category"{
            if selectIdx == indexPath {
                return self.cellHeight
            }
            return 44
            
        }
        return 0
    }
}
