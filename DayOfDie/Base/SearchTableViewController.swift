//
//  SearchTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/22/21.
//

import UIKit

class SearchTableViewController<T: Decodable & Searchable>: BaseTableViewController<T>, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredObjectList : [T] = []
    var searchPlaceholderString = "Search..."
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = searchPlaceholderString
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    //MARK: Search Functions
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredObjectList = objectList.filter { (object: T) -> Bool in
          return object.getSearchString().contains(searchText.lowercased())
      }
      tableView.reloadData()
    }

}
