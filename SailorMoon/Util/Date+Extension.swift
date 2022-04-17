//
//  Date+Extension.swift
//  SailorMoon
//
//  Created by LongDengYu on 2022/4/17.
//

import UIKit
import DateToolsSwift

extension Date{
    var formattedTime: String{
        return format(with: "yyyy-MM-dd HH:mm")
//        let currentYear = Date().year
//
//        //今年
//        if year == currentYear{
//            if isToday{
//                if minutesAgo < 10{
//                    return timeAgoSinceNow + "分钟前"
//                }else{
//                    return "今天 \(format(with: "HH:mm"))"
//                }
//            }else if isYesterday{
//                return "昨天 \(format(with: "HH:mm"))"
//            }else{
//                return format(with: "MM-dd")
//            }
//        }else if year < currentYear{
//            return format(with: "yyyy-MM-dd")
//        }else{
//            return "这个是未来的时间"
//        }
    }
}
