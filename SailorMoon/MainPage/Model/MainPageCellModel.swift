//
//  MainPageCellModel.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation

enum Priority {
    case red
    case blue
    case green
}

struct MainPageCellModel {
    let priority: Priority?
    let title: String?
}
