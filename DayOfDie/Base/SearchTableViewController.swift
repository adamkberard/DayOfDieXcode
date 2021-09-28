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
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
            return filteredObjectList.count
        }
        return objectList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[0], for: indexPath) as? BaseTableViewCell<T>  else {
            fatalError("The dequeued cell is not an instance of BaseTableViewCell.")
        }
        if isFiltering {
            cell.setupCell(object: filteredObjectList[indexPath.row])
        }
        else {
            cell.setupCell(object: objectList[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            selectedObject = filteredObjectList[indexPath.row]
        }
        else {
            selectedObject = objectList[indexPath.row]
        }
        self.performSegue(withIdentifier: tableSegueIdentifier, sender: self)
    }
    
    //MARK: Search Functions
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredObjectList = objectList.filter { (object: T) -> Bool in
          return object.getSearchString().lowercased().contains(searchText.lowercased())
      }
      tableView.reloadData()
    }

}
