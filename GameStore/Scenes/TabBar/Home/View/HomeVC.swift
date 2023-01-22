//
//  HomeVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pickerViewButton: UIButton!
    
    private let viewModel = HomeViewModel()
    private var collectionHelper : HomeVCCollectionHelper!
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 3
    var selectedRow = 0
    
    var games : KeyValuePairs =
        [
            "En Yeni Oyun" : "&ordering=created",
            "En Eski Oyun" : "&ordering=-created",
            "Popüler": ""
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.viewDidLoad(filterText: "")
    }
    
    @IBAction func popUpPicker(_ sender: UIButton){
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Filter", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = pickerViewButton
        alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.games)[self.selectedRow]
            let filter = selected.value
            let name = selected.key
            self.viewModel.viewDidLoad(filterText: filter)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension HomeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Array(games)[row].key
        label.sizeToFit()
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1 //return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        games.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 60
    }
    
    
}

private extension HomeVC{
    
    private func setupUI(){
        collectionHelper = .init(collectionView: collectionView, viewModel: viewModel, navigationController:navigationController!)
    }
    
    func setupBindings(){
        viewModel.onErrorDetected = {[weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        viewModel.refreshItems = {[weak self] items in
            self?.collectionHelper.setItems(items)
        }
    }
}
