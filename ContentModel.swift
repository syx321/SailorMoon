//
//  ContentModel.swift
//  SailorMoon
//
//  Created by LongDengYu on 2022/4/17.
//

import UIKit

struct ContentModel: Codable {
    let title: String?
    let content: String?
    let updateTime: Date?
    let buildTime: Date?
    let coverImage: Data?
    let contentImage: Data?
}
