//
//  BaseTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/22/21.
//

import UIKit

class BaseTableViewController<T: Decodable>: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    let myRefreshControl : UIRefreshControl = UIRefreshControl()
    var spinner = UIActivityIndicatorView(style: .large)
    var selectedObject : T?
    var tableView: UITableView!
    
    // Need to be set
    var rawObjectList: [T]! = []
    var objectList : [T]!
    var cellIdentifiers : [String]!
    var tableSegueIdentifier : String!
    var fetchURLEnding : String!
    var refreshTitleString : String!
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Finding and setting up the table.
        tableView = getTableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        setupTable()
        setupView()
        
        if rawObjectList.isEmpty {
            fetchObjectData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rawObjectList = setRawObjectList()
        objectList = setObjectList(rawList: rawObjectList)
        tableView.reloadData()
        setupView()
        fetchObjectData()
    }
    
    func getTableView() -> UITableView {
        // First we check if the view is a UITableView
        if view is UITableView {
            return view as! UITableView
        }
        
        let arr = view.subviews(ofType: UITableView.self)
        if arr.count == 1 {
            return arr.first! as UITableView
        }
        else {
            fatalError("There are this many table views: \(arr.count)")
        }
    }
    
    func setupTable() {
        rawObjectList = setRawObjectList()
        objectList = setObjectList(rawList: rawObjectList)
        cellIdentifiers = setCellIdentifiers()
        tableSegueIdentifier = setTableSegueIdentifier()
        fetchURLEnding = setFetchURLEnding()
        refreshTitleString = setRefreshTitleString()
        
        tableView.refreshControl = myRefreshControl
        myRefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        myRefreshControl.attributedTitle = NSAttributedString(string: refreshTitleString)
        for cellIdentifier in cellIdentifiers {
            tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    func setupView() {
        if setTitleString() != "" {
            self.title = setTitleString()
        }
    }
    
    // MARK: Override these functions
    func setRawObjectList() -> [T] { return [] }
    func setObjectList(rawList: [T]) -> [T] { return rawList }
    func setCellIdentifiers() -> [String] { return [] }
    func setTableSegueIdentifier() -> String { return "" }
    func setFetchURLEnding() -> String { return "" }
    func setRefreshTitleString() -> String { return "Fetching Data..." }
    func setTitleString() -> String { return "" }
    
    //MARK: Refresh Functions
    @objc func refresh(_ sender: Any) -> Void {
        spinner.startAnimating()
        fetchObjectData()
    }
    
    func fetchObjectData() {
        let url = URLInfo.baseUrl + fetchURLEnding
        APICalls.get(url: url, returnType: [T].self) { status, returnData in
            self.myRefreshControl.endRefreshing()
            self.spinner.stopAnimating()
            if status{
                self.objectList = self.setObjectList(rawList: returnData as! [T])
                self.tableView.reloadData()
            }
            else{
                let errors : [String] = returnData as! [String]
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[0], for: indexPath) as? BaseTableViewCell<T>  else {
            fatalError("The dequeued cell is not an instance of BaseTableViewCell.")
        }
        
        let cellObject = objectList[indexPath.row]
        cell.setupCell(object: cellObject)
        print("REFRESHING A CELL")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = objectList[indexPath.row]
        self.performSegue(withIdentifier: tableSegueIdentifier, sender: self)
    }
    
}

extension UIView {
    func subviews<T:UIView>(ofType WhatType:T.Type) -> [T] {
        var result = self.subviews.compactMap {$0 as? T}
        for sub in self.subviews {
            result.append(contentsOf: sub.subviews(ofType:WhatType))
        }
        return result
    }
}
