//
//  MainPageTableViewCell.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation
import UIKit

class MainPageTableViewCell: UITableViewCell {
    
    private lazy var symbolImageView: UIImageView = {
        var v = UIImageView()
        return v
    }()
    
    private lazy var nameLabel: UILabel = {
        var v = UILabel()
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
    
}
