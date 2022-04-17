//
//  ContentViewController.swift
//  SailorMoon
//
//  Created by LongDengYu on 2022/4/16.
//

import UIKit
import SnapKit

class ContentViewController: UIViewController {
    
    //    var title: String?
    //    var audio: Data?
    //    var content: String?
    //    var images: [UIImage]?
    //    var updateAt: Date?
    //    var buildTime: Date?
    //    var coverImage: UIImage?
    var contentModel: ContentModel?
    var displayUpdateTimeLable: Bool = false
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        // MARK: BUG待解决
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .quaternarySystemFill
        imageView.tintColor = .secondaryLabel
        let config = UIImage.SymbolConfiguration(pointSize: 46, weight: .medium, scale: .large)
        let image = UIImage(systemName: "plus", withConfiguration: config)
        imageView.image = contentModel?.coverImage ?? image
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
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        
        
        
        
        
        
        
    }
    
    
    func configLayout() {
        view.accessibilityIgnoresInvertColors = true
        view.backgroundColor = .quaternarySystemFill
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: contentTableViewCell)
        view.addSubview(tableView)
        
        
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
        tableView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.top.equalTo(titleField.snp.bottom).offset(12)
            make.height.equalTo(300)
        }
        coverImageView.isUserInteractionEnabled = true
        let clickAddImagePan = UITapGestureRecognizer(target: self, action: #selector(addImage))
        coverImageView.addGestureRecognizer(clickAddImagePan)
        
        // contentView
        tableView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.top.equalTo(coverImageView.snp.bottom).offset(12)
            make.bottom.equalTo(view.snp.bottom)
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
            timeLable.text = "更新于: \(contentModel?.updateAt ?? Date.now)"
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
            coverImageView.contentMode = .scaleAspectFill
            coverImageView.image = image
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



