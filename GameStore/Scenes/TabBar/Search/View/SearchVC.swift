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
        setupBindings()
        searchBar.text = ""
        searchBar.delegate = self
        
    }
}

private extension SearchVC {
    
    private func setupUI(){
        tableViewHelper = .init(tableView: tableView, viewModel: viewModel, navigationController: navigationController!)
    }
    
    private func setupBindings(){
        
        viewModel.showData = {[weak self] items in
            
        }
        
        viewModel.onErrorDetected = {[weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
    }
}

extension SearchVC :UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
}

