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
    
    var category: String = ""
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
        v.minimumLineSpacing = 10;
        v.minimumInteritemSpacing = 10;
        v.itemSize = CGSize(width: 170, height: 245)
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
        v.backgroundColor = .white()
        v.contentInsetAdjustmentBehavior = .automatic
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
    var dataSource: [ContentModel?] = []
    let useCase = ShowNoteUseCase()
    
    //MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupData()
    }
    
    private func setupSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(navigationView)
        navigationView.updateUI()
        containerView.addSubview(collectionView)
        
        navigationView.actionEvent = { [weak self] event in
            if event == .back {
                self?.navigationController?.popViewController(animated: true)
            } else if event == .add {
                let controller = ContentViewController()
                controller.category = self!.category
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
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
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupData() {
        self.useCase.getShowCollectionPageModels(self.category) {[weak self] models in
            self!.dataSource = models
            self!.collectionView.reloadData()
        }
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ShowNoteCollectionCell.self), for: indexPath) as! ShowNoteCollectionCell
        let model = self.dataSource[indexPath.row]! as ContentModel
        cell.updateUIWithModel(model)
        return cell
    }
    
    //MARK: UICollectionDataSource
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ContentViewController()
        let model = self.dataSource[indexPath.row]!
        controller.contentModel = model
        controller.category = category
        controller.contentIndex = indexPath.row
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
