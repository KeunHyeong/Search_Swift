//
//  SearchDetailVewCtr.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SearchDetailVewCtr: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let typeList = ["header","newfunction","collection","description","provider","size","category","age","copyright"]
    var selectIdx : IndexPath = IndexPath(row: 0, section: 0)
    var cellHeight : CGFloat = 0.0
    var functionCellHeight : CGFloat = 0.0
    let cache = NSCache<NSString, UIImage>()
    
    var info:SearchInfo?
    var disposeBag = DisposeBag()
    //    var tableViewItem :BehaviorSubject<SearchInfo>
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "SearchResultHeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib(nibName: "DetailTableCell", bundle: nil), forCellReuseIdentifier: "DetailTableCell")
        tableView.register(UINib(nibName: "DesDropTableCell", bundle: nil), forCellReuseIdentifier: "DesDropTableCell")
        tableView.register(UINib(nibName: "NewFunctionCell", bundle: nil), forCellReuseIdentifier: "NewFunctionCell")
        tableView.register(UINib(nibName: "ProviderCell", bundle: nil), forCellReuseIdentifier: "ProviderCell")
        tableView.register(UINib(nibName: "DetailCommonCell", bundle: nil), forCellReuseIdentifier: "DetailCommonCell")
        
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.disposeBag = DisposeBag()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToScreenShot" {
            let vc = segue.destination as? ScreenShotViewCtr
            vc?.info = self.info
        }
    }
    
    //    private func setTableView(){
    //        let cellType: Observable<[String]> = Observable.of(typeList)
    //
    //        cellType.bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: String) -> UITableViewCell in
    //            if element == "header"{
    //                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: IndexPath.init(row: index, section: 0)) as? SearchResultHeaderCell else{
    //                    return UITableViewCell()
    //                }
    //                cell.setViewDataObj(info: self.info!)
    //                return cell
    //            }
    //
    //
    //        }.disposed(by: disposeBag)
    //    }
    
    private func setTableView() {
        
        //        let cities = ["London", "Vienna", "Lisbon"]
        
        let cellType: Observable<[String]> = Observable.of(typeList)
        
        cellType.bind(to: tableView.rx.items) { (tableView, index, element) -> UITableViewCell in
            let idxPath = IndexPath.init(row: index, section: 0)
            
            if element == "header" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: idxPath) as? SearchResultHeaderCell else{
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: self.info!)
                return cell
                
            }else if element == "collection"{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCell", for: idxPath) as? DetailTableCell else{
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: self.info!)
                return cell
                
            } else if element == "description"{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DesDropTableCell", for: idxPath) as?  DesDropTableCell else{
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: self.info!)
                cell.animate()
                //                cellHeight = cell.cellHeight()
                return cell
                
            } else if element == "provider"{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderCell", for: idxPath) as? ProviderCell else {
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: self.info!)
                return cell
                
            } else if element == "newfunction"{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewFunctionCell", for: idxPath) as? NewFunctionCell else {
                    return UITableViewCell()
                }
                
                cell.setViewDataObj(info: self.info!)
                //                functionCellHeight = cell.cellHeight()
                
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommonCell", for: idxPath) as?  DetailCommonCell else{
                    return UITableViewCell()
                }
                
                if element == "age" {
                    cell.setViewDataObj(type:"연령 등급",info: self.info!)
                }else if element == "size"{
                    cell.setViewDataObj(type: "크기", info: self.info!)
                }else if element == "copyright" {
                    cell.setViewDataObj(type: "저작권", info: self.info!)
                }else if element == "category"{
                    cell.setViewDataObj(type: "카테고리", info: self.info!)
                }
                
                return cell
            }
        }.disposed(by: disposeBag)
    }
}

extension SearchDetailVewCtr : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
}

extension SearchDetailVewCtr : UITableViewDelegate {
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        if typeList[indexPath.row] == "collection"{
    //
    //            performSegue(withIdentifier: "goToScreenShot", sender: indexPath.row)
    //
    //        }else if typeList[indexPath.row] == "description" ||
    //            typeList[indexPath.row] == "newfunction"{
    //            selectIdx = indexPath
    //            tableView.beginUpdates()
    //            tableView.reloadRows(at: [selectIdx], with: .none)
    //            tableView.endUpdates()
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if typeList[indexPath.row] == "header" {
            return SearchResultHeaderCell.cellHeight()
        }else if typeList[indexPath.row] == "collection" {
            return DetailTableCell.cellHeight()
        }else if typeList[indexPath.row] == "description"{
            if selectIdx == indexPath {
                return cellHeight
            }
            return 200.0
        }else if typeList[indexPath.row] == "newfunction"{
            return functionCellHeight
        } else if typeList[indexPath.row] == "provider"{
            return ProviderCell.cellHeight()
        } else {
            return 44
        }
    }
}

//extension SearchDetailVewCtr : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return typeList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if typeList[indexPath.row] == "header" {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? SearchResultHeaderCell else{
//                 return UITableViewCell()
//             }
//             cell.setViewDataObj(info: self.info!)
//             return cell
//
//        }else if typeList[indexPath.row] == "collection"{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCell", for: indexPath) as? DetailTableCell else{
//                return UITableViewCell()
//            }
//            cell.setViewDataObj(info: self.info!)
//            return cell
//
//        } else if typeList[indexPath.row] == "description"{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DesDropTableCell", for: indexPath) as?  DesDropTableCell else{
//                return UITableViewCell()
//            }
//            cell.setViewDataObj(info: self.info!)
//            cell.animate()
//            cellHeight = cell.cellHeight()
//            return cell
//
//        } else if typeList[indexPath.row] == "provider"{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderCell", for: indexPath) as? ProviderCell else {
//                return UITableViewCell()
//            }
//            cell.setViewDataObj(info: self.info!)
//            return cell
//
//        } else if typeList[indexPath.row] == "newfunction"{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewFunctionCell", for: indexPath) as? NewFunctionCell else {
//                return UITableViewCell()
//            }
//
//            cell.setViewDataObj(info: self.info!)
//            functionCellHeight = cell.cellHeight()
//
//            return cell
//
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCommonCell", for: indexPath) as?  DetailCommonCell else{
//                return UITableViewCell()
//            }
//
//            if typeList[indexPath.row] == "age" {
//                cell.setViewDataObj(type:"연령 등급",info: self.info!)
//            }else if typeList[indexPath.row] == "size"{
//                cell.setViewDataObj(type: "크기", info: self.info!)
//            }else if typeList[indexPath.row] == "copyright" {
//                cell.setViewDataObj(type: "저작권", info: self.info!)
//            }else if typeList[indexPath.row] == "category"{
//                cell.setViewDataObj(type: "카테고리", info: self.info!)
//            }
//
//            return cell
//        }
//    }
//
//
//}
