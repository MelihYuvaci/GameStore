//
//  HomeVCPickerViewHelper.swift
//  GameStore
//
//  Created by Melih Yuvacı on 22.01.2023.
//

import UIKit

class HomeVCPickerViewHelper : NSObject{
    
    private weak var viewModel : HomeViewModel?
    private weak var pickerViewButton : UIButton?
    
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 3
    var selectedRow = 0
    
    var games : KeyValuePairs =
    [
        "Popüler": Constants.Home.PickerViewHelper.filterPopularValue,
        "En Eski Oyun" : Constants.Home.PickerViewHelper.filterOldValue,
        "En Yeni Oyun" : Constants.Home.PickerViewHelper.filterNewValue
    ]
    
    init(viewModel:HomeViewModel,pickerViewButton: UIButton) {
        self.viewModel = viewModel
        self.pickerViewButton = pickerViewButton
        super.init()
    }
    
    
}
//MARK: - PopUpPickerView

extension HomeVCPickerViewHelper {
    
    func popUpClicked()-> UIAlertController{
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
        alert.popoverPresentationController?.sourceRect = pickerViewButton!.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.games)[self.selectedRow]
            let filter = selected.value
            self.viewModel!.viewDidLoad(filterText: filter)
        }))
        
        return alert
        
    }
}


//MARK: - UIPickerViewDelegate

extension HomeVCPickerViewHelper: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Array(games)[row].key
        label.sizeToFit()
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 60
    }
    
}
//MARK: - UIPickerViewDataSource

extension HomeVCPickerViewHelper : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1 //return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        games.count
    }
}

