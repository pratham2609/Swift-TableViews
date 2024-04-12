//
//  RoomTypeTableViewController.swift
//  HotelCodeable
//
//  Created by Pratham on 11/04/24.
//

import UIKit

protocol RoomTypeTableViewControllerDelegate: AnyObject {
    func roomTypeTableViewController(_ controller: RoomTypeTableViewController, didSelect roomType: RoomType)
}

class RoomTypeTableViewController: UITableViewController {
    
    var roomType: RoomType?
    weak var delegate: RoomTypeTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.allTypes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = RoomType.allTypes[indexPath.row].name
        content.secondaryText = "$ \(RoomType.allTypes[indexPath.row].price)"
        cell.contentConfiguration = content
        if RoomType.allTypes[indexPath.row] == self.roomType {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        roomType = RoomType.allTypes[indexPath.row]
        delegate?.roomTypeTableViewController(self, didSelect: roomType!)
        tableView.reloadData()
    }
}
