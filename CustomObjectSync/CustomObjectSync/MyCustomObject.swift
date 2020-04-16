//
//  MyCustomObject.swift
//  CustomObjectSync
//
//  Created by Ashutosh Dave on 16/04/20.
//  Copyright © 2020 CustomObjectSyncOrganizationName. All rights reserved.
//

import Foundation
import MobileSync.SFMobileSyncConstants

enum MyCustomObjectConstants {
    static let kMyCustomObjectNameField    = "Name"
    static let kMyCustomObjectCustom_Name__cField     = "Custom_Name__c"
}

class MyCustomObjSObjectData: SObjectData {
    
    var name: String? {
        get {
            return super.nonNullFieldValue(MyCustomObjectConstants.kMyCustomObjectNameField) as? String
        }
        set {
            super.updateSoup(forFieldName: MyCustomObjectConstants.kMyCustomObjectNameField, fieldValue: newValue)
        }
    }
    
    var custom_Name__c: String? {
        get {
            return super.nonNullFieldValue(MyCustomObjectConstants.kMyCustomObjectCustom_Name__cField) as? String
        }
        set {
            super.updateSoup(forFieldName: MyCustomObjectConstants.kMyCustomObjectCustom_Name__cField, fieldValue: newValue)
        }
    }
    
   
    
//    var lastModifiedDate: String? {
//        get {
//            return super.nonNullFieldValue(kLastModifiedDate) as? String
//        }
//        set {
//            super.updateSoup(forFieldName: kLastModifiedDate, fieldValue: newValue)
//        }
//    }
    
    override init(soupDict: [String: Any]?) {
        super.init(soupDict: soupDict)
    }
    
    override init() {
        super.init()
    }
    
    override class func dataSpec() -> SObjectDataSpec? {
        var sDataSpec: MyCustomObjectSObjectDataSpec? = nil
        if sDataSpec == nil {
            sDataSpec = MyCustomObjectSObjectDataSpec()
        }
        return sDataSpec
    }
}

class MyCustomObjectSObjectDataSpec: SObjectDataSpec {
    
    convenience init() {
        let objectType = "MyCustomObject"
        let objectFieldSpecs = [
            SObjectDataFieldSpec(fieldName: MyCustomObjectConstants.kMyCustomObjectNameField, searchable: true),
            SObjectDataFieldSpec(fieldName: MyCustomObjectConstants.kMyCustomObjectCustom_Name__cField, searchable: true)
        ]
        let soupName = "mycustomobjects"
        let orderByFieldName: String  = MyCustomObjectConstants.kMyCustomObjectNameField
        self.init(objectType: objectType, objectFieldSpecs: objectFieldSpecs, soupName: soupName, orderByFieldName: orderByFieldName)
    }
    
    override class func createSObjectData(_ soupDict: [String : Any]?) throws -> SObjectData? {
        return MyCustomObjSObjectData(soupDict: soupDict)
    }
}
