//
//  ShowNoteCollectionCell.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation
import UIKit

class ShowNoteCollectionCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        var v = UIView()
        v.layer.cornerRadius = 15;
        v.layer.masksToBounds = true;
        v.isUserInteractionEnabled = true;
        v.contentMode = .scaleAspectFill
        v.backgroundColor = .white()
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        var v = UILabel()
        v.font = .boldSystemFont(ofSize: 30)
        return v
    }()
    
    private lazy var content: UILabel = {
        var v = UILabel()
        v.font = .systemFont(ofSize: 25)
        v.lineBreakMode = .byCharWrapping
        v.numberOfLines = 7
        v.textAlignment = .justified
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(content)
    }
    
    func setupConstraints() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.backgroundColor = .white()
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(10)
            make.height.equalTo(23)
        }
        content.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
    }
    
    func updateUIWithModel(_ model: ContentModel) {
        self.titleLabel.text = model.title!
        self.content.text = model.content!
    }
}
