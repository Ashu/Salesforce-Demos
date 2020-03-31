//
//  ViewController.swift
//  ChatbotTestApp
//
//  Created by Ashutosh Dave on 31/03/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit
import ServiceChat

class ViewController: UIViewController {
    
    let POD = "https://d.la2-c2-hnd.salesforceliveagent.com/chat"
    let ORG_ID = "00D2x000000DvlK"
    let DEPLOYMENT_ID = "5722x000000PBkD"
    let BUTTON_ID = "5732x000000PBsT"

    var chatConfig: SCSChatConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatConfig = SCSChatConfiguration(liveAgentPod: POD, orgId: ORG_ID, deploymentId: DEPLOYMENT_ID, buttonId: BUTTON_ID)
    }

    @IBAction func chatButtonTapped(_ sender: UIButton) {
        ServiceCloud.shared().chatUI.showChat(with: chatConfig!)
    }
    
}

