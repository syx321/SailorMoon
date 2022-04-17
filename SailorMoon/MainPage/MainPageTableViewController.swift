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

    var selectCell: MainPageTableViewCell? = nil
    //MARK: UI
    private lazy var containerView: UIView = {
        var v = UIView()
        v.backgroundColor = UIColor.white()
        return v
    }()
    
    private lazy var tableView: UITableView = {
        var v = UITableView()
//        v.backgroundColor = UIColor.white()
        v.showsVerticalScrollIndicator = false
        v.dataSource = self
        v.delegate = self
        v.estimatedRowHeight = 70
        v.separatorStyle = .none
        v.contentInsetAdjustmentBehavior = .never
        v.contentInset = .zero
        v.register(MainPageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(MainPageTableViewCell.self))
        return v
    }()
    
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
        view.addSubview(containerView)
        containerView.addSubview(navigationView)
        navigationView.updateUI()
        containerView.addSubview(tableView)
    }
    
    private func setupConstraints() {
        self.view.backgroundColor = UIColor.white()
        self.navigationController?.navigationBar.isHidden = true
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navigationView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(85)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
        navigationView.actionEvent = { [weak self] event in
            if event == .add {
                self?.insert()
            }
        }
    }
    
    private func setupData() {
        self.useCase.getMainPageModels {[weak self] models in
            self!.dataSource = models
            self!.tableView.reloadData()
        }
    }
    
    private func insert() {
        let alert = UIAlertController(title: "创建", message: nil, preferredStyle: .alert)
        var textField: UITextField = UITextField()
        alert.addTextField { textField in
            textField.placeholder = "请输入目录";
        }
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: {[weak self] action in
            textField = (alert.textFields?.first)!
            self?.dataSource.insert(MainPageCellModel(title: textField.text!), at: 0)
            self?.useCase.addDictionary(textField.text ?? "默认")
            self?.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        self.present(alert, animated: false, completion: nil)
    }
    
    //MARK: UITableViewDatasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MainPageTableViewCell.self), for: indexPath) as! MainPageTableViewCell
        let model = self.dataSource[indexPath.row]! as MainPageCellModel
        cell.updateUIWithModel(model)
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ShowNoteCollectionPageController()
        controller.category = self.dataSource[indexPath.row]!.title
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row]!
        self.dataSource.remove(at: indexPath.row)
        self.useCase.deletePageModel(model)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
}
