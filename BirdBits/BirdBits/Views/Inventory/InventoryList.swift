//
//  InventoryList.swift
//  BirdBits
//
//  Created by Jared Wheeler on 2/25/19.
//  Copyright © 2019 Bird Audio Machines. All rights reserved.
//

import UIKit

class InventoryList: UITableViewController {
    
    enum InventorySortType: String {
        case all
        case audioCaps
        case ceramicCaps
        case diodes
    }
    
    var selectedSortType: InventorySortType = .all
    var partData: [String: [PartModel]] = ["":[]]
    var sortedKeys: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellID = String(describing: InventoryCell.self)
        tableView.register(UINib(nibName: cellID, bundle: Bundle.main), forCellReuseIdentifier: cellID)        
    }
    
    private func partModel(for indexPath: IndexPath) -> PartModel? {
        guard let sectionPartData = partData[sortedKeys[indexPath.section]] else { return nil }
        return sectionPartData[indexPath.row]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return partData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedKeys[section]
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionPartData = partData[sortedKeys[section]] else { return 0 }
        return sectionPartData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(describing: InventoryCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        (cell as? InventoryCell)?.part = partModel(for: indexPath)
        return cell
    }
}
