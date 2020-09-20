//
//  SearchViewCtr.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class SearchViewCtr: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate{
    
    @IBOutlet weak var recentTableView: UITableView!
    
    let RELATED_TYPE = "related"
    let DETAIL_TYPE = "detail"
    let RECENT_TYPE = "recent"
    
    var searchController = UISearchController()
    var resultVC = UITableViewController()
    var recentSearchTermList:[String] = []
    var searchInfoData : [SearchInfo] = []
    var searchType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: resultVC)
        
        recentTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.backgroundColor = UIColor.white
        
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        recentTableView.delegate = self
        recentTableView.dataSource = self
        
        resultVC.tableView.delegate = self
        resultVC.tableView.dataSource = self
        
        searchType = RECENT_TYPE
        
        recentTableView.register(UINib(nibName: "SearchRecentCell", bundle: nil), forCellReuseIdentifier: "RecentCell")
        recentTableView.register(UINib(nibName: "SearchDetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        
        resultVC.tableView.register(UINib(nibName: "SearchRelatedCell", bundle: nil), forCellReuseIdentifier: "RelatedCell")
        resultVC.tableView.register(UINib(nibName: "SearchDetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        
        loadRecentList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func loadRecentList(){
        if !recentSearchTermList.isEmpty {
            recentSearchTermList.removeAll()
        }
        recentSearchTermList = UserDefaultManager.getRecentSearchTermList()
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
                let term = self.recentSearchTermList[indexPath.row]
                SearchAPI.requestSearch(term) { searchInfos in
                    DispatchQueue.main.async {
                        self.searchInfoData = searchInfos
                        tableView.reloadData()
                    }
                }
            }else{
                performSegue(withIdentifier: "ResultVC", sender: indexPath.row)
            }
            
        }else{ //resultVC
            if searchType == RELATED_TYPE{
                searchType = DETAIL_TYPE
                
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultVC" {
            let vc = segue.destination as? SearchDetailVewCtr
            if let idx = sender as? Int{
                vc?.info = searchInfoData[idx]
            }
        }
    }
}

extension SearchViewCtr : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if self.searchInfoData.isEmpty {
//            self.searchInfoData.removeAll()
            recentTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let term = searchBar.text, term.isEmpty == false else{
            searchType = RECENT_TYPE
            loadRecentList()
            
            self.searchInfoData.removeAll()
            resultVC.tableView.reloadData()
            return
        }
        
        resultVC.tableView.contentInset = UIEdgeInsets(top: 60,left: 0,bottom: 60,right: 0)
        
        searchType = RELATED_TYPE
        
        SearchAPI.requestSearch(term) { searchInfos in
            DispatchQueue.main.async {
                self.searchInfoData = searchInfos
                self.resultVC.tableView.reloadData()
            }
        }
    }
}

extension SearchViewCtr : UISearchBarDelegate {
    
    private func dismissKeyboard(){
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        func dismissKeyboard(){
            searchBar.resignFirstResponder()
        }
        
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else {
            return
        }
        
        if !recentSearchTermList.contains(searchTerm) {
            recentSearchTermList.insert(searchTerm, at: 0)
            UserDefaultManager.setRecentSearchTermList(recentList: recentSearchTermList)
        }
        
        searchType = DETAIL_TYPE
        resultVC.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchType = RECENT_TYPE
        loadRecentList()
        self.searchInfoData.removeAll()
        recentTableView.reloadData()
    }
}

