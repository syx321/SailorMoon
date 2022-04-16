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
        let lable = UILabel()
        lable.text = "创建于: \(Date.now)"
        view.addSubview(lable)
        lable.textColor = .secondaryLabel
        lable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
    private lazy var titleField: TextField = {
        let textField = TextField()
        let attributeString = NSAttributedString("请输入标题")
        let typeString:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.secondaryLabel,
            .font: UIFont.systemFont(ofSize: 30)
        ]
        textField.attributedPlaceholder = attributeString
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
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: <#T##Double#>)
//        scrollView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        scrollView.backgroundColor = .systemGray6
//
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//        return scrollView
//    }()
    
//    func recursivelyAddSubView(views: [UIView]) {
//        for view in views {
//            self.view.addSubview(view)
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
        
        
        
        
        
    }
    
    func configLayout() {
        view.accessibilityIgnoresInvertColors = true
        view.backgroundColor = .white
//        view.addSubview(scrollView)
//        scrollView.addSubview(coverImageView)
        
        // buildTimeView
        view.addSubview(buildTimeView)
        buildTimeView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
//        let clickBuildTimeViewTap = UITapGestureRecognizer(target: self, action: #selector(clickBuildTimeView))
        
        // titleTextField
        view.addSubview(titleField)
        titleField.snp.makeConstraints { make in
            make.top.equalTo(buildTimeView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        // imageView
        view.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(titleField.snp.bottom).offset(12)
            make.height.equalTo(300)
        }
        coverImageView.isUserInteractionEnabled = true
        let clickAddImagePan = UITapGestureRecognizer(target: self, action: #selector(addImage))
        coverImageView.addGestureRecognizer(clickAddImagePan)
        
        // contentView
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(coverImageView.snp.bottom).offset(12)
            make.height.equalTo(1000)
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
    
//    @objc func clickBuildTimeView() {
//
//    }
    


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


