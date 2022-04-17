//
//  Storage.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/17.
//

import Foundation

class Storage{
    static func getAllData() -> [String: [ContentModel]] {
        if let data = UserDefaults.standard.data(forKey: "DataSource"){
            do{
                return(try JSONDecoder().decode([String: [ContentModel]].self, from: data))
            }catch{
                print(error)
            }
        }
        return [:]
    }
    
    static func storageCategory(_ title: String) {
        
        var dict:[String: [ContentModel]] = Storage.getAllData()
        dict[title] = []
        do{
            //因为存储的内容不是Swift的基本类型，所以首先先编码
            let data = try JSONEncoder().encode(dict)
            //再进行存储
            UserDefaults.standard.set(data, forKey: "DataSource")
        }catch{
            print(error)
        }
    }
    
    static func deleteCategory(_ title: String) {
        var dict:[String: [ContentModel]] = Storage.getAllData()
        dict.removeValue(forKey: title)
        do{
            //因为存储的内容不是Swift的基本类型，所以首先先编码
            let data = try JSONEncoder().encode(dict)
            //再进行存储
            UserDefaults.standard.set(data, forKey: "DataSource")
        }catch{
            print(error)
        }
    }
    
    static func deleteContent(_ title: String, _ index: Int) {
        var dict:[String: [ContentModel]] = Storage.getAllData()
        var models = dict[title]!
        models.remove(at: index)
        dict[title] = models
        do{
            //因为存储的内容不是Swift的基本类型，所以首先先编码
            let data = try JSONEncoder().encode(dict)
            //再进行存储
            UserDefaults.standard.set(data, forKey: "DataSource")
        }catch{
            print(error)
        }
    }
}
