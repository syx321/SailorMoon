//
//  ViewController.swift
//  SailorMoon
//
//  Created by 苏易肖 on 2022/4/16.
//

import UIKit
import SnapKit

//let mStatusBarAndNaviBarHeight = 30

class MainPageTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: UI
    private lazy var tableView: UITableView = {
        var v = UITableView()
        v.backgroundColor = .white
        v.showsVerticalScrollIndicator = false
        v.dataSource = self
        v.delegate = self
        v.estimatedRowHeight = 70
        v.separatorStyle = .none
        v.contentInsetAdjustmentBehavior = .never
        v.contentInset = .zero
        v.register(MainPageTableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        return v
    }()
    
    private let cellIdentifer = "MainPageTableViewCell"
    
    private lazy var navigationView: SMNavigationView = {
        let v = SMNavigationView()
        v.isShowCloseItem = false
        v.isShowBackItem = false
        v.isShowAddItem = true
        v.title = "分类"
        return v
    }()
    
    //MARK: 数据
    lazy var useCase: MainPageUseCase = {
        let v = MainPageUseCase()
        return v
    }()
    
    var dataSource: [MainPageCellModel?] = []
    
    //MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.setupData()
        self.setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(navigationView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.navigationView.updateUI()
        navigationView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(85)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(3)
            make.left.bottom.right.equalToSuperview().inset(5)
        }
    }
    
    private func setupData() {
        self.useCase.getMainPageModels {[weak self] models in
            self!.dataSource = models
            self!.tableView.reloadData()
        }
    }
    
    //MARK: UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! MainPageTableViewCell
        let model = self.dataSource[indexPath.row]! as MainPageCellModel
        cell.updateUIWithModel(model)
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
}
