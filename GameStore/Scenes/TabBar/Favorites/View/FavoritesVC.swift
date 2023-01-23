//
//  FavoritesVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
}

private extension  FavoritesVC{
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "ReusableFavoriteCell")
    }
    
}

extension FavoritesVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension FavoritesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableFavoriteCell", for: indexPath) as! FavoriteCell
        cell.favorites = viewModel.favoritesAtIndex(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alertController = UIAlertController(title: "Delete?", message: "Are you want to delete this favorite game?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
                self.viewModel.deleteItem(indexPath.row) { _ in
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnimationVC") as? AnimationVC{
                        vc.navigationItem.hidesBackButton = true
                        vc.jsonName = "79053-delete-message"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }))
            alertController.addAction(UIAlertAction(title: "NO", style: .destructive))
            present(alertController, animated: true)
          
        }
        
    }
}

