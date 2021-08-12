//
//  AddFriendViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

class AddFriendViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var addUsersTable: UserTableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        addUsersTable.delegate = addUsersTable
        addUsersTable.dataSource = addUsersTable
        addUsersTable.parentView = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addUsersTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        addUsersTable.reloadData()
    }
}
