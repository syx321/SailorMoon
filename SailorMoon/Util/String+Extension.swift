//
//  String+Extension.swift
//  SailorMoon
//
//  Created by LongDengYu on 2022/4/17.
//

import UIKit

extension String{
    var isBlank: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String{
    var unwarpString: String{ self ?? "" }

}
