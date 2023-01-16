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
        if let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
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
            OnboardingItemInfo(informationImage: UIImage(named: "Hotels")!,
                               title: "Hotels",
                               description: "All hotels and hostels are sorted by hospitality rating",
                               pageIcon: UIImage(named: "Key")!,
                               color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.systemFont(ofSize: 36),
                               descriptionFont: UIFont.systemFont(ofSize: 14)),
            
            OnboardingItemInfo(informationImage: UIImage(named: "Banks")!,
                               title: "Banks",
                               description: "We carefully verify all banks before add them into the app",
                               pageIcon: UIImage(named: "Wallet")!,
                               color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.systemFont(ofSize: 36),
                               descriptionFont: UIFont.systemFont(ofSize: 14)),
            
            OnboardingItemInfo(informationImage: UIImage(named: "Stores")!,
                               title: "Stores",
                               description: "All local stores are categorized for your convenience",
                               pageIcon: UIImage(named: "Shopping-cart")!,
                               color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.systemFont(ofSize: 36),
                               descriptionFont: UIFont.systemFont(ofSize: 14))
        ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
}


