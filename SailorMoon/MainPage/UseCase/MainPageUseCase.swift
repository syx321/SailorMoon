//
//  MainPageUseCase.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation

class MainPageUseCase: NSObject {
    func getMainPageModels(completion: ([MainPageCellModel?]) -> Void) {
//        completion([MainPageCellModel(title: "这是一个分类"),
//                    MainPageCellModel(title: "这是一个分类"),
//                    MainPageCellModel(title: "这是一个分类"),
//                    MainPageCellModel(title: "这是一个分类"),])
        var result:[MainPageCellModel] = []
        let dict = Storage.getAllData()
        for item in dict {
            result.append(MainPageCellModel(title: item.key))
        }
        completion(result)
    }
    
    func deletePageModel(_ model: MainPageCellModel) {
        Storage.deleteCategory(model.title)
    }
    
    func addDictionary(_ title: String) {
        Storage.storageCategory(title)
    }
}
