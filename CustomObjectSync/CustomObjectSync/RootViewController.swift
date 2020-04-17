/*
 Copyright (c) 2015-present, salesforce.com, inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Foundation
import UIKit
import MobileSync

class RootViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    fileprivate var sObjectsDataManager = SObjectDataManager(dataSpec: MyCustomObjSObjectData.dataSpec()!)
    fileprivate var customObj: MyCustomObjSObjectData?
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        let syncBarButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(syncUpDown))
        self.navigationItem.rightBarButtonItem = syncBarButton
	}
    
    @IBAction func saveTapped(_ sender: UIButton) {
        saveFieldsIfRequired()
    }
    
    @objc func syncUpDown(){
        let alert = self.showAlert("Syncing", message: "Syncing with Salesforce")
        sObjectsDataManager.updateRemoteData({ [weak self] (sObjectsData) in
            DispatchQueue.main.async {
                alert.message = "Sync Complete!"
                alert.dismiss(animated: true, completion: nil)
//                self?.refreshList()
            }
        }, onFailure: { [weak self] (error, syncState) in
            alert.message = "Sync Failed!"
            alert.dismiss(animated: true, completion: nil)
//            self?.refreshList()
        })
    }
    
    fileprivate func saveFieldsIfRequired() {
        
        guard let customObject = self.customObj else {return}
        
        customObject.name = self.nameTextField.text
        
        do {
           _ = try self.sObjectsDataManager.createLocalData(customObj)
       } catch let error as NSError{
            MobileSyncLogger.e(RootViewController.self, message: "Add local data failed \(error)" )
       }
    }
    
    fileprivate func showAlert(_ title:String, message:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        return alert
    }
}
