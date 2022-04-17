//
//  MainPageTableViewCell.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation
import UIKit

enum EditType{
    case edit
    case delete
}

class MainPageTableViewCell: UITableViewCell {
    
    var editType: EditType = .delete
    
    private lazy var containerView: UIView = {
        var v = UIView()
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(indicator)
    }
    
    func setupConstraints() {
        self.selectionStyle = .none
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview()
        }
        indicator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
            make.width.height.equalTo(50)
        }
    }
    
    func updateUIWithModel(_ model: MainPageCellModel) {
        self.titleLabel.text = model.title
    }
}
