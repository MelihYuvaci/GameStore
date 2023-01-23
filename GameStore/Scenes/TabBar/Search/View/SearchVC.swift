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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = SearchViewModel()
    private var tableViewHelper : SearchVCTableViewHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        setupUI()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.text = ""
        tableViewHelper.items.removeAll()
        tableView?.reloadData()
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
            self?.viewModel.viewDidLoad(searchText: "")
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        viewModel.isLoadingIndicatorShowing = {[weak self] isShowing in
            self?.activityIndicator.isHidden = !isShowing
            isShowing ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        
    }
}



extension SearchVC :UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            tableViewHelper.items.removeAll()
            tableView?.reloadData()
        }else {
            setupBindings()
            viewModel.viewDidLoad(searchText: searchText)
        }
        
    }
}



