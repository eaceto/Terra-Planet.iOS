//
//  ViewController.swift
//  Terra Planet
//
//  Created by f0go on 22/03/2022.
//

import UIKit
import SwiftyJSON

class FirstVC: UIViewController {

    override func viewDidLoad() {
        loadWallet { hasWallet in
            self.redirect(hasWallet: hasWallet)
        }
    }
    
    func redirect(hasWallet: Bool) {
        var nextView = ["Onboarding","OBNav"]
        if hasWallet {
            nextView = ["Home","HomeVC"]
        }
        let vc = UIStoryboard(name: nextView[0], bundle: nil).instantiateViewController(withIdentifier: nextView[1])
        DispatchQueue.main.async {
            self.present(vc, animated: false)
        }
    }
}
