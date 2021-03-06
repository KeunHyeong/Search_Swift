//
//  SearchViewCtr.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit
import Firebase
import RxSwift

class SearchViewCtr: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate{
    
    @IBOutlet weak var recentTableView: UITableView!
    
    let RELATED_TYPE = "related"
    let DETAIL_TYPE = "detail"
    let RECENT_TYPE = "recent"
    
    var searchController = UISearchController()
    var resultVC = UITableViewController()
    var recentSearchTermList:[SearchTermInfo] = []
    var searchInfoData : [SearchInfo] = []
    var searchType = ""
    let db = Database.database().reference().child("searchHistory")
    //    var searchTerms:[SearchTermInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewCtr()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecentList()
    }
    
    private func setupViewCtr(){
        searchController = UISearchController(searchResultsController: resultVC)
        
        if #available(iOS 13.0, *){
            let window = UIApplication.shared.windows.first{$0.isKeyWindow}
            let statusBarManager = window?.windowScene?.statusBarManager
            let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBarView.backgroundColor = UIColor.white
            searchController.view.addSubview(statusBarView)
        }else{
            let statusBarFrame = UIApplication.shared.statusBarFrame
            let statusBarView = UIView(frame: statusBarFrame)
            statusBarView.backgroundColor = .white
            searchController.view.addSubview(statusBarView)
        }
        
        recentTableView.tableHeaderView = searchController.searchBar
        
        searchController.navigationController?.navigationBar.isTranslucent = false
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "취소"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "검색", style: .plain, target: nil, action: nil)
        
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        recentTableView.delegate = self
        recentTableView.dataSource = self
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
        
        searchType = RECENT_TYPE
        
        recentTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        resultVC.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        recentTableView.register(UINib(nibName: "SearchRecentCell", bundle: nil), forCellReuseIdentifier: "RecentCell")
        recentTableView.register(UINib(nibName: "SearchDetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        
        resultVC.tableView.register(UINib(nibName: "SearchRelatedCell", bundle: nil), forCellReuseIdentifier: "RelatedCell")
        resultVC.tableView.register(UINib(nibName: "SearchDetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultVC" {
            let vc = segue.destination as? SearchDetailVewCtr
            if let idx = sender as? Int{
                vc?.info = searchInfoData[idx]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == recentTableView {
            if searchType == RECENT_TYPE {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentCell", for: indexPath) as? SearchRecentCell else{
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: recentSearchTermList[indexPath.row])
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? SearchDetailCell else{
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: self.searchInfoData[indexPath.row])
                return cell
            }
        }else{
            if searchType == RELATED_TYPE{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedCell", for: indexPath) as? SearchRelatedCell else{
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: self.searchInfoData[indexPath.row])
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? SearchDetailCell else{
                    return UITableViewCell()
                }
                cell.setViewDataObj(info: self.searchInfoData[indexPath.row])
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == recentTableView {
            if searchType == RECENT_TYPE {
                searchType = DETAIL_TYPE
            }
            
            if self.searchInfoData.isEmpty {
                let info = self.recentSearchTermList[indexPath.row]
                SearchAPI
                    .shared
                    .requestSearch(searchTerm: info.term,
                               completion: { result in
                                self.searchInfoData = result
                                tableView.reloadData()
                                
            
                    })
                //                SearchAPI.requestSearch(info.term) { searchInfos in
                //                    DispatchQueue.main.async {
                //                        self.searchInfoData = searchInfos
                //                        tableView.reloadData()
                //                    }
                //                }
            }else{
                performSegue(withIdentifier: "ResultVC", sender: indexPath.row)
            }
            
        }else{ //resultVC
            if searchType == RELATED_TYPE{
                searchType = DETAIL_TYPE
                
                let info = SearchTermInfo(term:self.searchInfoData[indexPath.row].title!)
                insertRecentTerm(recentInfo: info)
                searchController.searchBar.resignFirstResponder()
            }else{
                performSegue(withIdentifier: "ResultVC", sender: indexPath.row)
                searchType = DETAIL_TYPE
            }
            resultVC.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == recentTableView {
            if searchType == RECENT_TYPE {
                return recentSearchTermList.count
            }else{
                print("self.searchInfo.Data count -->\(self.searchInfoData.count)")
                return self.searchInfoData.count
            }
        }else{
            print("self.searchInfoData count -->\(self.searchInfoData.count)")
            return self.searchInfoData.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == recentTableView {
            if searchType == RECENT_TYPE {
                return SearchRecentCell.cellHeight()
            }else{
                return SearchDetailCell.cellHeight()
            }
        }else{
            if searchType == RELATED_TYPE{
                return SearchRelatedCell.cellHeight()
            } else {
                return SearchDetailCell.cellHeight()
            }
        }
    }
    
    func loadRecentList(){
        db.observeSingleEvent(of: .value, with: {(snapshot) in
            
            guard let searchHistory = snapshot.value as? [String:Any] else { return }
            
            let data = try! JSONSerialization.data(withJSONObject: Array(searchHistory.values), options: [])
            
            let decoder = JSONDecoder()
            let searchTerms = try! decoder.decode([SearchTermInfo].self, from: data)
            self.recentSearchTermList = searchTerms.sorted{ $0.timeStamp > $1.timeStamp }
            if self.recentSearchTermList.count == 20{
                self.recentSearchTermList.remove(at: 19)
            }
            self.recentTableView.reloadData()
        })
    }
    
    func insertRecentTerm(recentInfo: SearchTermInfo) {
        var searchExsit: Bool = false
        for info in self.recentSearchTermList {
            if info.term == recentInfo.term{
                searchExsit = true
                break
            }
        }
        
        if !searchExsit {
            let timeStamp:Double = Date().timeIntervalSince1970.rounded()
            self.db.childByAutoId().setValue(["term":recentInfo.term,"timeStamp":timeStamp])
        }
    }
}

extension SearchViewCtr : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchInfoData.removeAll()
        recentTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let term = searchBar.text, term.isEmpty == false else{
            searchType = RECENT_TYPE
            loadRecentList()
            
            self.searchInfoData.removeAll()
            resultVC.tableView.reloadData()
            recentTableView.reloadData()
            return
        }
        
        resultVC.tableView.contentInset = UIEdgeInsets(top: 60,left: 0,bottom: 60,right: 0)
        
        searchType = RELATED_TYPE
        
//        SearchAPI.requestSearch(term) { searchInfos in
//            DispatchQueue.main.async {
//                if !self.searchInfoData.isEmpty{
//                    self.searchInfoData.removeAll()
//                }
//                self.searchInfoData = searchInfos
//                self.resultVC.tableView.reloadData()
//            }
//        }
        SearchAPI
            .shared
            .requestSearch(searchTerm: term,
                       completion: { result in
                        DispatchQueue.main.async {
                            self.searchInfoData = result
                            self.resultVC.tableView.reloadData()

                        }
                        

            })
        //                SearchAPI.requestSearch(info.term) { searchInfos in
        //                    DispatchQueue.main.async {
        //                        self.searchInfoData = searchInfos
        //                        tableView.reloadData()
        //                    }
        //                }
    }
}

extension SearchViewCtr : UISearchBarDelegate {
    
    private func dismissKeyboard(){
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dismissKeyboard()
        
        guard let term = searchBar.text, term.isEmpty == false else {
            return
        }
        
        let info = SearchTermInfo(term:searchBar.text!)
        insertRecentTerm(recentInfo: info)
        searchType = DETAIL_TYPE
        resultVC.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchType = RECENT_TYPE
        loadRecentList()
        self.searchInfoData.removeAll()
    }
}

