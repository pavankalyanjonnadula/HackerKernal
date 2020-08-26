//
//  HomeViewController.swift
//  HackerKernelTask
//
//  Created by Pavan Kalyan Jonnadula on 07/04/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var postsContainerView: UIView!
    @IBOutlet weak var photosContainerView: UIView!
    @IBOutlet weak var homeSegmentController: UISegmentedControl!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = 25
        homeSegmentController.selectedSegmentIndex = 0
        photosContainerView.isHidden = false
        postsContainerView.isHidden = true
    }

    @IBAction func sideMenuAction(_ sender: Any) {
        let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SideMenuVC") as! SideMenuVC
        menu.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        menu.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        menu.viewnavigationController = self.navigationController
        menu.sideMenuTabBar = self.tabBarController
        self.present(menu, animated: false, completion: nil)
    }
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            photosContainerView.isHidden = false
            postsContainerView.isHidden = true
        }else{
            photosContainerView.isHidden = true
            postsContainerView.isHidden = false
        }
    }
}
