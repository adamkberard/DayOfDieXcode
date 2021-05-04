//
//  AddFriendViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

class AddFriendViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var allUsersTable: AddUserTableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        allUsersTable.delegate = allUsersTable
        allUsersTable.dataSource = allUsersTable
        allUsersTable.parentView = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        allUsersTable.reloadData()
    }
}
