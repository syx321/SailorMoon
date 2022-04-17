//
//  ContentViewController.swift
//  SailorMoon
//
//  Created by LongDengYu on 2022/4/16.
//

import UIKit
import SnapKit

enum OpenPageType {
    case add
    case edit
}

class ContentViewController: UIViewController {
    
    var contentIndex: Int = 0
    var category: String = ""
    var contentModelArray: [ContentModel]?
    var dataSource: [String: [ContentModel]?]?
    
    var openType: OpenPageType = .edit
    var contentModel: ContentModel?
    var displayUpdateTimeLable: Bool = false
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .quaternarySystemFill
        imageView.tintColor = .secondaryLabel
        let config = UIImage.SymbolConfiguration(pointSize: 46, weight: .medium, scale: .large)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        imageView.image = image
        return imageView
    }()
    
    private lazy var buildTimeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var timeLable: UILabel = {
        let lable = UILabel()
        lable.text = "创建于: \(Date.now)"
        lable.textColor = .secondaryLabel
        return lable
    }()
    
    private lazy var titleField: TextField = {
        let textField = TextField()
        textField.attributedPlaceholder = NSAttributedString.init(string:"请输入标题", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel])
        textField.font = .systemFont(ofSize: 30)
        textField.backgroundColor = .quaternarySystemFill
        textField.insetX = 10
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var contentView: UITextView = {
        let textView = UITextView()
        textView.text = "请输入内容"
        textView.textColor = .secondaryLabel
        textView.backgroundColor = .quaternarySystemFill
        textView.font = .systemFont(ofSize: 23)
        textView.delegate = self
        return textView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = .zero
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var navigationView: SMNavigationView = {
        let v = SMNavigationView()
        v.isShowCloseItem = true
        v.isShowBackItem = false
        v.isShowAddItem = false
        v.isShowDeleteItem = true
        v.title = "编辑"
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        dataFromContentModel()
    }
    
    func dataFromContentModel() {
        
        self.dataSource = Storage.getAllData()
        //拿到之前存储的Model
        guard let contentModel = contentModel else { return }
        contentModelArray = dataSource![self.category] ?? []
        contentImageView.image = UIImage(optionalData: contentModel.contentImage)
        contentImageView.contentMode = .scaleAspectFill
        titleField.text = contentModel.title
        contentView.text = contentModel.content
        timeLable.text = "创建于: \(contentModel.buildTime?.formattedTime ?? Date.now.formattedTime)"
    }
    
//    //拿到所有的数据
//    func getAllData() {
//        if let data = UserDefaults.standard.data(forKey: "DataSource"){
//            do{
//                dataSource = try JSONDecoder().decode([String: [ContentModel]].self, from: data)
//            }catch{
//                print(error)
//            }
//        }
//    }
    
    //存储
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !titleField.exctString.isEmpty || !contentView.exctString.isEmpty || contentImageView.image != nil {
            do{
                // 拿到数组
                contentModelArray = dataSource![self.category] ?? []
                if contentModel == nil {
                    // 新建
                    contentModel = ContentModel(title: titleField.exctString, content: contentView.exctString, updateTime: Date.now, buildTime: contentModel?.buildTime, coverImage: contentImageView.image?.jpegCompress(.middle), contentImage: contentImageView.image?.pngData())
                    // 追加
                    contentModelArray?.append(contentModel!)
                } else {
                    // 修改
                    contentModel = ContentModel(title: titleField.exctString, content: contentView.exctString, updateTime: Date.now, buildTime: contentModel?.buildTime, coverImage: contentImageView.image?.jpegCompress(.middle), contentImage: contentImageView.image?.pngData())
                    // 修改具体ContentModel
                    contentModelArray![self.contentIndex] = contentModel!
                }
                dataSource![self.category] = contentModelArray
                let data = try JSONEncoder().encode(dataSource)
                //再进行存储
                UserDefaults.standard.set(data, forKey: "DataSource")
            }catch{
                print(error)
            }
        } else {
            //无内容 删除该contentModel
            contentModelArray?.remove(at: contentIndex)
        }
    }
    
    func configLayout() {
        view.accessibilityIgnoresInvertColors = true
        view.backgroundColor = .quaternarySystemFill
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: contentTableViewCell)
        view.addSubview(tableView)
        self.navigationController?.navigationBar.isHidden = true
        
        // buildTimeView
        tableView.addSubview(buildTimeView)
        buildTimeView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.top.equalTo(tableView.snp.top).offset(5)
        }
        let clickBuildTimeViewTap = UITapGestureRecognizer(target: self, action: #selector(clickBuildTimeView))
        buildTimeView.addGestureRecognizer(clickBuildTimeViewTap)
        
        // timeLable
        buildTimeView.addSubview(timeLable)
        timeLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // titleTextField
        tableView.addSubview(titleField)
        titleField.snp.makeConstraints { make in
            make.top.equalTo(buildTimeView.snp.bottom).offset(12)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.height.equalTo(50)
        }
        
        // imageView
        tableView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.top.equalTo(titleField.snp.bottom).offset(12)
            make.height.equalTo(300)
        }
        contentImageView.isUserInteractionEnabled = true
        let clickAddImagePan = UITapGestureRecognizer(target: self, action: #selector(addImage))
        contentImageView.addGestureRecognizer(clickAddImagePan)
        
        // contentView
        tableView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.top.equalTo(contentImageView.snp.bottom).offset(12)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(85)
        }
        navigationView.updateUI()
        var tmp = 1
        navigationView.actionEvent = {[weak self] event in
            if event == .close {
                self?.navigationController?.popViewController(animated: true)
            } else if event == .delete {
                if tmp == 1{
                    Storage.deleteContent(self!.category, self!.contentIndex)
                    self?.navigationController?.popViewController(animated: true)
                }
                tmp -= 1
            }
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func addImage() {
        let alert = UIAlertController(title: "提示", message: "选择方式添加图片", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        let photoLibrary = UIAlertAction(title: "相册", style: .default) { _ in self.clickPhotoLibrary() }
        let camera = UIAlertAction(title: "相机", style: .default) { _ in self.clickCamera()}
        alert.addAction(cancel)
        alert.addAction(photoLibrary)
        alert.addAction(camera)
        present(alert, animated: true)
    }
    
    @objc func clickBuildTimeView() {
        displayUpdateTimeLable = !displayUpdateTimeLable
        if displayUpdateTimeLable {
            timeLable.text = "更新于: \(contentModel?.updateTime ?? Date.now)"
        } else {
            timeLable.text = "创建于: \(contentModel?.buildTime ?? Date.now)"
        }
        
    }
}

// 选择照片功能
extension ContentViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func clickCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    func clickPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            contentImageView.contentMode = .scaleAspectFill
            contentImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ContentViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "请输入内容" {
            textView.textColor = .label
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "请输入内容"
            textView.textColor = .secondaryLabel
        }
    }
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contentTableViewCell)!
        return cell
    }
}



