//
//  PostsViewController.swift
//  HackerKernelTask
//
//  Created by Pavan Kalyan Jonnadula on 07/04/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var postTableView: UITableView!
    var postArray = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllPosts()
    }
    func getAllPosts(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
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
                self.postArray = jsonObj as? [NSDictionary] ?? []
                DispatchQueue.main.async {
                    self.postTableView.delegate = self
                    self.postTableView.dataSource = self
                    self.postTableView.reloadData()
                }
           
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postcell = tableView.dequeueReusableCell(withIdentifier: "post") as! PostTableViewCell
        let data = postArray[indexPath.row]
        postcell.titleLabel.text = data.object(forKey: "title") as? String ?? ""
        postcell.descriptionLabel.text = data.object(forKey: "body") as? String ?? ""
        return postcell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    

}

class PostTableViewCell : UITableViewCell{
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}
