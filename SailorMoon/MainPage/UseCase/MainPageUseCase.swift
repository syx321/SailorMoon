//
//  MainPageUseCase.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation

class MainPageUseCase: NSObject {
    func getMainPageModels(completion: ([MainPageCellModel?]) -> Void) {
        completion([MainPageCellModel(title: "这是一个分类"),
                    MainPageCellModel(title: "这是一个分类"),
                    MainPageCellModel(title: "这是一个分类"),
                    MainPageCellModel(title: "这是一个分类"),])
    }
    
    func deletePageModel(_ model: MainPageCellModel) {
        
    }
    
    func addDictionary(_ title: String) {
        
    }
}
