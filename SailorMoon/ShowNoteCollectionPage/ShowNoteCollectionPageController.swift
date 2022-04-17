//
//  ShowNoteCollectionPageController.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import Foundation
import UIKit
import SnapKit

class ShowNoteCollectionPageController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: UI
    private lazy var containerView: UIView = {
        var v = UIView()
        v.backgroundColor = UIColor.backgroundColor()
        return v
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        var v = UICollectionViewFlowLayout()
        v.scrollDirection = .vertical
        v.sectionInset = .zero
        v.minimumLineSpacing = 12;
        v.minimumInteritemSpacing = 12;
        v.itemSize = CGSize(width: 175, height: 234)
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        var v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.dataSource = self
        v.delegate = self
        v.backgroundColor = UIColor.backgroundColor()
        v.showsVerticalScrollIndicator = false;
        v.showsHorizontalScrollIndicator = false;
        v.layer.masksToBounds = false;
        v.register(ShowNoteCollectionCell.self, forCellWithReuseIdentifier: NSStringFromClass(ShowNoteCollectionCell.self))
        return v
    }()
    
    private lazy var navigationView: SMNavigationView = {
        let v = SMNavigationView()
        v.isShowCloseItem = false
        v.isShowBackItem = true
        v.isShowAddItem = true
        v.title = "便签"
        return v
    }()
    
    //MARK: data
    var dataSource: [ShowNoteModel?] = []
    let useCase = ShowNoteUseCase()
    
    //MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.setupData()
        self.setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(navigationView)
        navigationView.updateUI()
        containerView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        self.view.backgroundColor = UIColor.backgroundColor()
        self.navigationController?.navigationBar.isHidden = true
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navigationView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(85)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(3)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupData() {
        self.useCase.getMainPageModels {[weak self] models in
            self!.dataSource = models
            self!.collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ShowNoteCollectionCell.self), for: indexPath)
        
        return cell
    }
    
    
}
