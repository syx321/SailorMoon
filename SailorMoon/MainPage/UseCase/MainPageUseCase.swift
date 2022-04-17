//
//  MainPageUseCase.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation

class MainPageUseCase: NSObject {
    func getMainPageModels(completion: ([MainPageCellModel?]) -> Void) {
        completion([MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .green, title: "这是一个分类"),
                    MainPageCellModel(priority: .blue, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),
                    MainPageCellModel(priority: .red, title: "这是一个分类"),])
    }
}
