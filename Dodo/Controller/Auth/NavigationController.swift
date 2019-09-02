//
//  NavigationController.swift
//  Dodo
//
//  Created by Frederic Orlando on 28/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

final class NavigationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func navigate(vc: UIViewController, storyboard: String, to vcId: String)
    {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: vcId)
        
        vc.present(view, animated: false, completion: nil)
    }
    
    class func navigateToHome(vc: UIViewController)
    {
        navigate(vc: vc, storyboard: "Main", to: "UITabBarController-LZ5-tm-lEc")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
