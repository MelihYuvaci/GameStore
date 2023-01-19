//
//  SearchVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = SearchViewModel()
    private var tableViewHelper : SearchVCTableViewHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.text = ""
        viewModel.viewDidLoad(searchText: "")
    }
}

private extension SearchVC {
    
    private func setupUI(){
        tableViewHelper = .init(tableView: tableView, viewModel: viewModel, navigationController: navigationController!)
    }
    
    private func setupBindings(){
        
        viewModel.showData = {[weak self] items in
            self?.tableViewHelper.setItems(items)
        }
        
        viewModel.onErrorDetected = {[weak self] message in
            self?.searchBar.text = ""
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
    }
}



extension SearchVC :UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setupBindings()
        viewModel.viewDidLoad(searchText: searchText)
    }
}



