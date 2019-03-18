//
//  InventoryOverviewList.swift
//  BirdBits
//
//  Created by Jared Wheeler on 2/25/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import UIKit

enum SelectedInventoryType: String {
    case all
    case audioCap
    case ceramicCap
}

class InventoryOverviewList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak private var tableView: UITableView!
    
    private var isLoading = false
    var partData: [String: [PartModel]] = ["":[]]
    var sortedKeys: [String] = []
    var selectedInventoryType: SelectedInventoryType = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellID = String(describing: InventoryOverviewCell.self)
        tableView.register(UINib(nibName: cellID, bundle: Bundle.main), forCellReuseIdentifier: cellID)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !isLoading else { return }
        isLoading = true
        InventoryEndpoint.loadAllInventory(for: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let inventoryList = segue.destination as? InventoryList {
            inventoryList.selectedSortType = .all
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(describing: InventoryOverviewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        let headline = indexPath.row == 0 ? "all" : sortedKeys[indexPath.row-1]
        (cell as? InventoryOverviewCell)?.headline = headline
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowInventoryList", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension InventoryOverviewList: InventoryEndpointConsumer {
    func update(with newInventoryData: [String: [PartModel]]) {
        self.partData = newInventoryData
        let nestedResponseKeys = Array(newInventoryData.keys)
        self.sortedKeys = nestedResponseKeys.sorted(by: {$0 < $1})
        self.tableView.reloadData()
    }
}
