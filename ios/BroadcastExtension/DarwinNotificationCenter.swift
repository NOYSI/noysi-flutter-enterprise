//
//  DarwinNotificationCenter.swift
//  BroadcastExtension
//
//  Created by Rolando Govea on 4/29/22.
//  Copyright © 2022 The Chromium Authors. All rights reserved.
//

import Foundation

enum DarwinNotification: String {
    case broadcastStarted = "iOS_BroadcastStarted"
    case broadcastStopped = "iOS_BroadcastStopped"
}

class DarwinNotificationCenter {
    
    static let shared = DarwinNotificationCenter()
    
    private let notificationCenter: CFNotificationCenter
    
    init() {
        notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
    }
    
    func postNotification(_ name: DarwinNotification) {
        CFNotificationCenterPostNotification(notificationCenter, CFNotificationName(rawValue: name.rawValue as CFString), nil, nil, true)
    }
}