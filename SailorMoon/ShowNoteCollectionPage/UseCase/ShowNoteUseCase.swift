//
//  ShowNoteUseCase.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation

class ShowNoteUseCase: NSObject {
    func getShowCollectionPageModels(_ title: String, completion: ([ContentModel?]) -> Void) {
        let dict = Storage.getAllData()
        completion(dict[title] ?? [])
    }
}
