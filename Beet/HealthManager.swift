//
//  HealthManager.swift
//  heartrate
//
//  Created by Gilad Oved on 4/15/17.
//  Copyright © 2017 gilad.oved.test1. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class HealthManager: NSObject {
    
    static let healthKitStore = HKHealthStore()
    
    static func authorizeHealthKit() {
        
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
            ]
        
        healthKitStore.requestAuthorization(toShare: nil,
                                            read: healthKitTypes) { _, _ in }
    }
}
