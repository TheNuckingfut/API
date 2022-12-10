//
//  ViewController.swift
//  Api
//
//  Created by Felix IT on 03/10/22.
//  Copyright © 2022 Felix IT. All rights reserved.
//

import UIKit

struct Post: Decodable{
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class ViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    var postArray: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    func fetchPosts() {
        let str = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                self.postArray = try JSONDecoder().decode([Post].self, from: data!)
                    DispatchQueue.main.async {
                        self.postTableView.reloadData()
                    }
                } catch let error{
                    print(error.localizedDescription)
                    
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    let post = postArray[indexPath.row]
    cell?.textLabel?.text = post.title
    cell?.detailTextLabel?.text = post.body
    return cell!
}


}
