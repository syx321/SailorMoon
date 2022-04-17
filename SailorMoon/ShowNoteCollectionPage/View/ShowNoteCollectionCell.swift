//
//  ShowNoteCollectionCell.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation
import UIKit

class ShowNoteCollectionCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        var v = UILabel()
        v.font = .boldSystemFont(ofSize: 40)
        return v
    }()
    
    private lazy var note: UILabel = {
        var v = UILabel()
        v.font = .systemFont(ofSize: 38)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(note)
    }
    
    func setupConstraints() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        self.backgroundColor = .white()
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        note.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
}
