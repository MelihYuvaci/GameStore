//
//  NotesVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class NotesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = NotesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NewNoteVC") as? NewNoteVC{
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension  NotesVC{
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NotesCell", bundle: nil), forCellReuseIdentifier: "ReusableNotesCell")
    }
}

extension NotesVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension NotesVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableNotesCell", for: indexPath) as! NotesCell
        cell.notes = viewModel.notesAtIndex(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alertController = UIAlertController(title: "Delete?", message: "Are you want to delete this note", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
                self.viewModel.deleteItem(indexPath.row) { _ in
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }))
            alertController.addAction(UIAlertAction(title: "NO", style: .destructive))
            present(alertController, animated: true)
        }
    }
}




