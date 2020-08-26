//
//  DashBoardViewController.swift
//  HackerKernelTask
//
//  Created by Pavan Kalyan Jonnadula on 07/04/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit
import SideMenu
class DashBoardViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    var photos = ["p-1","p-2","p-3","p-4","p-5"]
    var videos = ["photo","v-2","v-3","v-4","v-5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstCollectionView.reloadData()
        secondCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if collectionView == firstCollectionView{
            return CGSize(width: (self.view.frame.width/2) , height: firstCollectionView.frame.height)
        }else{
            return CGSize(width: (self.view.frame.width/1.3), height: secondCollectionView.frame.height)

        }
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if firstCollectionView == collectionView{
            let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "first", for: indexPath) as! FirstCollectionCell
            if indexPath.item == 1 || indexPath.item == 2 || indexPath.item == 4{
                firstCell.favouriteBtn.isHidden = false
                firstCell.starBtn.tintColor = UIColor.link
            }
            else{
                firstCell.favouriteBtn.isHidden = true
                firstCell.starBtn.tintColor = UIColor.lightGray
            }
            firstCell.photoImageView.image = UIImage(named: photos[indexPath.item])
        
            return firstCell
        }else{
            let secondcell = collectionView.dequeueReusableCell(withReuseIdentifier: "second", for: indexPath) as! SecondCollectionCell
            secondcell.photoImage.image = UIImage(named: videos[indexPath.item])
            return secondcell
            
        }
    }
    @IBAction func sideMenuAction(_ sender: Any) {
        let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SideMenuVC") as! SideMenuVC
        menu.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
             menu.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        menu.viewnavigationController = self.navigationController
        menu.sideMenuTabBar = self.tabBarController

        self.present(menu, animated: false, completion: nil)
    }
}

class FirstCollectionCell : UICollectionViewCell{
    
    @IBOutlet weak var despLabel: UILabel!
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
}

class SecondCollectionCell : UICollectionViewCell{
    
    @IBOutlet weak var photoImage: UIImageView!
}
