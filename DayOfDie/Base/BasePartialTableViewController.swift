//
//  BasePartialTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/22/21.
//

import UIKit

class BasePartialTableViewController<T: Decodable>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let myRefreshControl = UIRefreshControl()
    
    var tableObjectList : [T] = []
    var selectedObject : T?
    
    // Need to be set
    var cellIdentifier : String!
    var tableSegueIdentifier : String!
    var fetchURLPostfix : String!
    
    // MARK: View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.refreshControl = myRefreshControl
        myRefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        myRefreshControl.attributedTitle = NSAttributedString(string: "Fetching Data...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchObjectData()
    }
    
    // MARK: Refresh Functions
    
    @objc func refresh(_ sender: Any) -> Void {
        fetchObjectData()
    }
    
    func fetchObjectData() {
        let url = URLInfo.baseUrl + fetchURLPostfix
        APICalls.get(url: url, returnType: [T].self) { status, returnData in
            if status{
                self.tableObjectList = returnData as! [T]
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
    // MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableObjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BaseTableViewCell<T>  else {
            fatalError("The dequeued cell is not an instance of BaseTableViewCell.")
        }
        
        let cellObject = tableObjectList[indexPath.row]
        
        cell.setupCell(object: cellObject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = tableObjectList[indexPath.row]
        self.performSegue(withIdentifier: tableSegueIdentifier, sender: self)
    }
}
