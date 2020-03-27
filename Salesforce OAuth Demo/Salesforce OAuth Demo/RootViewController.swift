//
//  RootViewController.swift
//  Salesforce OAuth Demo
//
//  Created by Ashutosh Dave on 27/03/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit
import SalesforceSDKCore

class RootViewController: UITableViewController {

    var dataSource = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Salesforce Demo App"
        
        let request = RestClient.shared.request(forQuery: "SELECT Name FROM Contact LIMIT 10", apiVersion: SFRestDefaultAPIVersion)
        
        RestClient.shared.send(request: request) { [weak self] (result) in
            switch result {
                case .success(let response):
                    self?.handleSuccess(response: response, request: request)
                case .failure(let error):
                    SalesforceLogger.d(RootViewController.self, message: "Error invoking: \(request), \(error)")
            }
        }
    }

    func handleSuccess(response: RestResponse, request: RestRequest) {
        guard let jsonResponse = try? response.asJson() as? [String: Any], let records = jsonResponse["records"] as? [[String: Any]] else {
            SalesforceLogger.d(RootViewController.self, message: "Empty Response for: \(request)")
            return
        }
        SalesforceLogger.d(type(of: self), message: "Invoked: \(request)")
        DispatchQueue.main.async {
            self.dataSource = records
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let obj = dataSource[indexPath.row]
        cell.textLabel?.text = obj["Name"] as? String

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
