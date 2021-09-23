//
//  BaseTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/22/21.
//

import UIKit

class BaseTableViewController<T: Decodable>: UITableViewController {
    
    private let myRefreshControl = UIRefreshControl()
    var refreshTitleString = "Fetching Data..."
    
    // Need to be set
    var objectList : [T] = []
    var cellIdentifier : String!
    var tableSegueIdentifier : String!
    var fetchURLPostfix : String!
    
    var selectedObject : T?
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.refreshControl = myRefreshControl
        myRefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        myRefreshControl.attributedTitle = NSAttributedString(string: "Fetching Data...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: Refresh Functions
    @objc func refresh(_ sender: Any) -> Void {
        fetchObjectData()
    }
    
    func fetchObjectData() {
        let url = URLInfo.baseUrl + fetchURLPostfix
        APICalls.get(url: url, returnType: [T].self) { status, returnData in
            if status{
                self.objectList = returnData as! [T]
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objectList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BaseTableViewCell<T>  else {
            fatalError("The dequeued cell is not an instance of BaseTableViewCell.")
        }
        
        let cellObject = objectList[indexPath.row]
        cell.setupCell(object: cellObject)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = objectList[indexPath.row]
        self.performSegue(withIdentifier: tableSegueIdentifier, sender: self)
    }
    
}
