//
//  UIImage+Extension.swift
//  SailorMoon
//
//  Created by LongDengYu on 2022/4/17.
//

import UIKit

extension UIImage{
    convenience init?(optionalData: Data?){
        if let data = optionalData {
            self.init(data: data)
        }else{
            return nil
        }
    }
    enum jpegCompressEnum: Double{
        case low = 0
        case betterLow = 0.25
        case middle = 0.5
        case high = 0.75
        case Highest = 1
    }
    func jpegCompress(_ compress: jpegCompressEnum) -> Data?{
        return jpegData(compressionQuality: compress.rawValue)
    }
}
