//
//  SMNavigationView.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation
import UIKit

enum SMNavigationEvent {
    case back
    case close
    case add
}

typealias SMNavigationAction = (_ envet: SMNavigationEvent) -> ()

class SMNavigationView: UIView {
    
    private let itemSizeHeigt: CGFloat       = 30.0
    private let itemSizeWidth: CGFloat       = 30.0
    private let itemSmailSpace: CGFloat      = 6.0
    private let itemBigSpace: CGFloat        = 10.0
    
    private let backIcon        = "chevron.backward"
    private let closeIcon       = "xmark"
    private let addIcon         = "plus.circle"
    private let defaultTitle = "分类"
    
    var isShowTitleItem     = true
    var isShowCloseItem     = false
    var isShowBackItem      = false
    var isShowAddItem       = false

    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    var actionEvent: SMNavigationAction?
    
    lazy var backButton:   UIButton = createButtonItem(backIcon,    #selector(backAction))
    lazy var closeButton:  UIButton = createButtonItem(closeIcon,   #selector(closeAction))
    lazy var addButton:    UIButton = createButtonItem(addIcon,     #selector(addAction))
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private func createButtonItem(_ imagename: String, _ action: Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: imagename), for: .normal)
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }
    
    lazy var line: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    private func setupUI() -> Void {
        self.backgroundColor = UIColor.backgroundColor()
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(itemBigSpace)
            make.bottom.equalToSuperview().inset(3)
            make.width.height.equalTo(itemSizeHeigt)
        }
        backButton.imageView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(itemSizeHeigt);
        }
        
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.edges.equalTo(backButton)
        }
        closeButton.imageView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(itemBigSpace)
            make.centerY.equalTo(backButton)
            make.width.height.equalTo(itemSizeHeigt)
        }
        addButton.imageView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    func updateUI() -> Void {
        backButton.isHidden     = !isShowBackItem
        titleLabel.isHidden     = !isShowTitleItem
        closeButton.isHidden    = !isShowCloseItem
        addButton.isHidden      = !isShowAddItem
        titleLabel.isHidden     = !isShowTitleItem
        if isShowTitleItem {
            titleLabel.text = title ?? defaultTitle
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SMNavigationView {
    @objc private func backAction() -> Void {
        if actionEvent != nil {
            actionEvent!(.back)
        }
    }
    
    @objc private func closeAction() -> Void {
        if actionEvent != nil {
            actionEvent!(.close)
        }
    }
    
    @objc private func addAction() -> Void {
        if actionEvent != nil {
            actionEvent!(.add)
        }
    }
}
