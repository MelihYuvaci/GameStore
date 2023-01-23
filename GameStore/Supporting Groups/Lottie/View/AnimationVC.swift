//
//  AnimationVC.swift
//  GameStore
//
//  Created by Melih Yuvacı on 24.01.2023.
//

import UIKit
import Lottie

class AnimationVC: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    
    var jsonName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.stopAnimation()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func lottieAnimation(){
        animationView = .init(name: jsonName ?? "")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 700)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .playOnce
    }
    func stopAnimation(){
        animationView.stop()
    }
    
}
