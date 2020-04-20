//
//  Orders.swift
//  CustomObjectSync
//
//  Created by Ashutosh Dave on 20/04/20.
//  Copyright © 2020 CustomObjectSyncOrganizationName. All rights reserved.
//

import Foundation
import MobileSync.SFMobileSyncConstants

enum OrderConstants {
    static let kOrderNameField          = "Order_Name__c"
    static let kOrderTypeField          = "Order_Type__c"
    static let kOrderDescriptionField   = "Order_Description__c"
}

class OrderSObjectData: SObjectData {
    
    var orderName: String? {
        get {
            return super.nonNullFieldValue(OrderConstants.kOrderNameField) as? String
        }
        set {
            super.updateSoup(forFieldName: OrderConstants.kOrderNameField, fieldValue: newValue)
        }
    }
    
    var orderType: String? {
        get {
            return super.nonNullFieldValue(OrderConstants.kOrderTypeField) as? String
        }
        set {
            super.updateSoup(forFieldName: OrderConstants.kOrderTypeField, fieldValue: newValue)
        }
    }
    
    var orderDescription: String? {
        get {
            return super.nonNullFieldValue(OrderConstants.kOrderDescriptionField) as? String
        }
        set {
            super.updateSoup(forFieldName: OrderConstants.kOrderDescriptionField, fieldValue: newValue)
        }
    }
    
    var lastModifiedDate: String? {
        get {
            return super.nonNullFieldValue(kLastModifiedDate) as? String
        }
        set {
            super.updateSoup(forFieldName: kLastModifiedDate, fieldValue: newValue)
        }
    }
    
    override init(soupDict: [String: Any]?) {
        super.init(soupDict: soupDict)
    }
    
    override init() {
        super.init()
    }
    
    override class func dataSpec() -> SObjectDataSpec? {
        var sDataSpec: OrderSObjectDataSpec? = nil
        if sDataSpec == nil {
            sDataSpec = OrderSObjectDataSpec()
        }
        return sDataSpec
    }
}

class OrderSObjectDataSpec: SObjectDataSpec {
    
    convenience init() {
        let objectType = "Order"
        let objectFieldSpecs = [
            SObjectDataFieldSpec(fieldName: OrderConstants.kOrderNameField, searchable: true),
            SObjectDataFieldSpec(fieldName: OrderConstants.kOrderTypeField, searchable: true),
            SObjectDataFieldSpec(fieldName: OrderConstants.kOrderDescriptionField, searchable: true)
        ]
        let soupName = "Orders"
        let orderByFieldName: String  = OrderConstants.kOrderNameField
        self.init(objectType: objectType, objectFieldSpecs: objectFieldSpecs, soupName: soupName, orderByFieldName: orderByFieldName)
    }
    
    override class func createSObjectData(_ soupDict: [String : Any]?) throws -> SObjectData? {
        return OrderSObjectData(soupDict: soupDict)
    }
}
