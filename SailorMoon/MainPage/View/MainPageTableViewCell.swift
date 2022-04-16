//
//  MainPageTableViewCell.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation
import UIKit

class MainPageTableViewCell: UITableViewCell {
    
    private lazy var circle: UIView = {
        var v = UIView()
        v.layer.cornerRadius = 25; //设置圆形的程度
        v.layer.masksToBounds = true; //设置是否切圆
        v.layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        v.layer.borderWidth = 1; //设置圆环的粗细宽度
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        var v = UILabel()
        v.font = .boldSystemFont(ofSize: 40)
        return v
    }()
    
    private lazy var indicator: UIImageView = {
        var v = UIImageView()
        v.image = UIImage(systemName: "arrow.right")
        
        return v
    }()
    var circleLayer: CAShapeLayer = CAShapeLayer.init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(circle)
        addSubview(titleLabel)
        addSubview(indicator)
    }
    
    func setupConstraints() {
//        self.selectionStyle = .none
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        circle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(5)
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(circle.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
        }
        indicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
            make.width.height.equalTo(50)
        }
    }
    
    func updateUIWithModel(_ model: MainPageCellModel) {
        self.titleLabel.text = model.title!
        switch model.priority {
        case .red:
            self.circle.backgroundColor = .red
        case .green:
            self.circle.backgroundColor = .green
        case .blue:
            self.circle.backgroundColor = .blue
        case .none:
            self.circle.backgroundColor = .none
            
        }
        
    }
}
