//
//  PhotosViewController.swift
//  HackerKernelTask
//
//  Created by Pavan Kalyan Jonnadula on 07/04/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var photosCollectionView: UICollectionView!
    var photosArray = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        gettAllPhotos()
    }
    //MARK: API Calls
    func gettAllPhotos() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(response)")
                    return
            }
            
            if let data = data,let jsonObj = try? JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions.allowFragments){
                print("the obj string",jsonObj)
                self.photosArray = jsonObj as? [NSDictionary] ?? []
                DispatchQueue.main.async {
                    self.photosCollectionView.delegate = self
                    self.photosCollectionView.dataSource = self
                    self.photosCollectionView.reloadData()
                }
           
            }
        })
        task.resume()
    }
    //MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionCell
        let data = photosArray[indexPath.item]
        let url = data.object(forKey: "thumbnailUrl") as? String ?? ""
        let title = data.object(forKey: "title") as? String ?? ""
        let imageurl = URL(string: url)

        cell.photoImage.downloadImage(from: imageurl!)
        cell.titleLabel.text = title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let nbCol = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)    }
}

class PhotoCollectionCell : UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
