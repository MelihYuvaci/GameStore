//
//  SearchVCTableViewHelper.swift
//  GameStore
//
//  Created by Melih Yuvacı on 19.01.2023.
//

import UIKit

class SearchVCTableViewHelper: NSObject {
    
    typealias RowItem = SearchCellModel
    
    private let cellIdentifier = Constants.Search.TableViewHelper.cellIdentifier
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
    
}

//MARK: - Setup TableView & Items

extension SearchVCTableViewHelper{
    
    private func setupTableView(){
        tableView?.register(.init(nibName: Constants.Search.TableViewHelper.nibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func setItems(_ items: [RowItem]){
        self.items = items
        tableView?.reloadData()
    }
    
}

//MARK: - UITableViewDelegate

extension SearchVCTableViewHelper : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.Search.TableViewHelper.storyboardName, bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: Constants.Search.TableViewHelper.navigationIdentifier) as? DetailsVC{
            vc.detailID = items[indexPath.row]?.id
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - UITableViewDataSource

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


