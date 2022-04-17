//
//  ShowNoteUseCase.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation

class ShowNoteUseCase: NSObject {
    func getMainPageModels(completion: ([ShowNoteModel?]) -> Void) {
        completion([ShowNoteModel(title: "某个便签", note: "这是主要内容")])
    }
}
