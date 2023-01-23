//
//  SearchVCTableViewHelper.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import UIKit

class SearchVCTableViewHelper: NSObject {
    
    typealias RowItem = SearchCellModel
    
    private let cellIdentifier = "ReusableSearchCell"
    private var tableView : UITableView?
    private weak var viewModel : SearchViewModel?
    private weak var navigationController: UINavigationController?
    
    var items : [RowItem?] = []
    
    init(tableView: UITableView, viewModel: SearchViewModel, navigationController: UINavigationController) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init()
        self.setupTableView()
        self.navigationController = navigationController
    }
    
    private func setupTableView(){
        tableView?.register(.init(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func setItems(_ items: [RowItem]){
        self.items = items
        tableView?.reloadData()
    }
    
}

extension SearchVCTableViewHelper : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC{
            vc.detailID = items[indexPath.row]?.id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchVCTableViewHelper : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchCell
        cell.configure(with: items[indexPath.row]!)
        return cell
    }
}


