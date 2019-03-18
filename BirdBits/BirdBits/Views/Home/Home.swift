//
//  Home.swift
//  BirdBits
//
//  Created by Jared Wheeler on 2/25/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import UIKit

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak private var tableView: UITableView!
    
    fileprivate let homeMenu = ["Inventory", "Build Calculator"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellID = String(describing: HomeCell.self)
        tableView.register(UINib(nibName: cellID, bundle: Bundle.main), forCellReuseIdentifier: cellID)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(describing: HomeCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        (cell as? HomeCell)?.headline = homeMenu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowInventoryOverview", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
