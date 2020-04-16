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
	  
	  // MARK: - View lifecycle
	  override func loadView() {
		  super.loadView()
		  self.title = "Mobile SDK Sample App"
		  let request = RestClient.shared.request(forQuery: "SELECT Name FROM Contact LIMIT 10", apiVersion: SFRestDefaultAPIVersion)
		  
		  RestClient.shared.send(request: request) { [weak self] (result) in
			  switch result {
				  case .success(let response):
					  self?.handleSuccess(response: response, request: request)
				  case .failure(let error):
					   SalesforceLogger.d(RootViewController.self, message:"Error invoking: \(request) , \(error)")
			  }
		  }
	
		  //NOTE: An alternative way of consuming the response
		  //RestClient.shared.send(request: request) { [weak self] (result) in
		  //   do {
		  //      try self?.handleSuccess(response: result.get(),request: request)
		  //   }
		  //   catch(let error) {
		  //       SalesforceLogger.d(RootViewController.self, message:"Error invoking: \(request) , \(error)")
		  //   }
		  //}
	  
	  }
	  
	  func handleSuccess(response: RestResponse, request: RestRequest) {
		  guard let jsonResponse  = try? response.asJson() as? [String:Any], let records = jsonResponse["records"] as? [[String:Any]]  else {
				  SalesforceLogger.d(RootViewController.self, message:"Empty Response for : \(request)")
				  return
		  }
		  SalesforceLogger.d(type(of:self), message:"Invoked: \(request)")
		  DispatchQueue.main.async {
			 self.dataRows = records
			 self.tableView.reloadData()
		 }
	  }

	  
	  // MARK: - Table view data source
	  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		  return 1
	  }
	  
	  override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
		  return self.dataRows.count
	  }
	  
	  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		  let cellIdentifier = "CellIdentifier"
		  
		  // Dequeue or create a cell of the appropriate type.
		  let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
		  
		  // If you want to add an image to your cell, here's how.
		  let image = UIImage(named: "icon.png")
		  cell.imageView?.image = image
		  
		  // Configure the cell to show the data.
		  let obj = dataRows[indexPath.row]
		  cell.textLabel?.text = obj["Name"] as? String
		  
		  // This adds the arrow to the right hand side.
		  cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
		  return cell
	  }
}
