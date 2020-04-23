//
//  CustomObjectsViewController.swift
//  CustomObjectSync
//
//  Created by Ashutosh Dave on 15/04/20.
//  Copyright © 2020 CustomObjectSyncOrganizationName. All rights reserved.
//

import UIKit
import SalesforceSDKCore

class CustomObjectsViewController: UITableViewController {
    
    var dataRows = [[String: Any]]()
    
    fileprivate var sObjectsDataManager = SObjectDataManager(dataSpec: OrderSObjectData.dataSpec()!)
    fileprivate var orderObject: OrderSObjectData?
    
    // MARK: - View lifecycle
    override func loadView() {
        super.loadView()
        self.title = "Mobile SDK Sample App"
        syncUpDown()
    }
    
    func syncUpDown(){
        let alert = self.showAlert("Syncing", message: "Syncing with Salesforce")
        sObjectsDataManager.updateRemoteData({ [weak self] (sObjectsData) in
            DispatchQueue.main.async {
                alert.message = "Sync Complete!"
                alert.dismiss(animated: true, completion: nil)
                self?.refreshList()
            }
        }, onFailure: { [weak self] (error, syncState) in
            alert.message = "Sync Failed!"
            alert.dismiss(animated: true, completion: nil)
            self?.refreshList()
        })
    }
    
    fileprivate func refreshList() {
        self.sObjectsDataManager.filter(onSearchTerm: "") {[weak self]  dataRows in
             DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    fileprivate func showAlert(_ title:String, message:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        return alert
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return self.sObjectsDataManager.dataRows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        // Dequeue or create a cell of the appropriate type.
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        let newOrderObject = self.sObjectsDataManager.dataRows[indexPath.row] as! OrderSObjectData
          
        cell.textLabel?.text = newOrderObject.orderName
        cell.detailTextLabel?.text = newOrderObject.orderDescription
        
        return cell
    }
}
