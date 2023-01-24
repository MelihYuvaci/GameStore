//
//  ViewController.swift
//  GameStore
//
//  Created by Melih Yuvacı on 16.01.2023.
//

import UIKit
import paper_onboarding

class OnboardVC: UIViewController {
    
    
    @IBOutlet weak var skipButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.isHidden = true
        setupPaperOnboardingView()
        view.bringSubviewToFront(skipButton)
        
    }
    /// Configure Onboarding View
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    
    @IBAction func skipButtonClicked(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Tabbar") as? UITabBarController {
            vc.navigationItem.hidesBackButton = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - PaperOnboardingDelegate
extension OnboardVC: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }
    
}

//MARK: - PaperOnboardingDataSource
extension OnboardVC:PaperOnboardingDataSource{
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "Character")!,
                               title: "Browse Games",
                               description: "You can examine the games as you wish and have information",
                               pageIcon: UIImage(systemName: "gamecontroller")!,
                               color: UIColor(red: 0.33, green: 0.69, blue: 0.88, alpha: 1.00),
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.systemFont(ofSize: 36),
                               descriptionFont: UIFont.systemFont(ofSize: 14)),
            
            OnboardingItemInfo(informationImage: UIImage(named: "Character2")!,
                               title: "Add Favorites",
                               description: "You can add them to favorites and review them later",
                               pageIcon: UIImage(systemName: "cart")!,
                               color: UIColor(red: 0.46, green: 0.91, blue: 0.70, alpha: 1.00),
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.systemFont(ofSize: 36),
                               descriptionFont: UIFont.systemFont(ofSize: 14)),
            
            OnboardingItemInfo(informationImage: UIImage(named: "Character3")!,
                               title: "Take Note",
                               description: "You can make comments and take notes about the games",
                               pageIcon: UIImage(systemName: "book")!,
                               color: UIColor(red: 0.97, green: 0.82, blue: 0.37, alpha: 1.00),
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: UIFont.systemFont(ofSize: 36),
                               descriptionFont: UIFont.systemFont(ofSize: 14))
        ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
}


