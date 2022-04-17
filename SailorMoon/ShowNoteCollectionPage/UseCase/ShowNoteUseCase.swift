//
//  ShowNoteUseCase.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation

class ShowNoteUseCase: NSObject {
    func getMainPageModels(completion: ([ContentModel?]) -> Void) {
        completion([ContentModel(title: "title", content: "content", updateTime: nil, buildTime: nil, coverImage: nil)])
    }
}
