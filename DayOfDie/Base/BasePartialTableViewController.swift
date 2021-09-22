//
//  BasePartialTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/22/21.
//

import UIKit

class BasePartialTableViewController<T: Decodable>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    // Need to be set
    var cellIdentifier : String!
    var tableSegueIdentifier : String!
    var fetchURLPostfix : String!
    
    var tableObjectList : [T] = []
    var selectedObject : T?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        fetchObjectData()
    }
    
    
    func fetchObjectData() {
        let url = URLInfo.baseUrl + fetchURLPostfix
        APICalls.get(url: url, returnType: [T].self) { status, returnData in
            if status{
                self.tableObjectList = returnData as! [T]
                self.tableView.reloadData()
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
            fatalError("The dequeued cell is not an instance of GameTableViewCell.")
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
