//
//  CurrentEventGlobalAccess.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/2/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import Foundation
import Firebase


class CurrentEventGlobalAccess
{
    static let globalData = CurrentEventGlobalAccess()
    private init() {}
    var globalEvent: Event!
    var globalPlayer: Player!
    var role: String!
    var owner: Bool = false
    var loading: Bool = true
}
