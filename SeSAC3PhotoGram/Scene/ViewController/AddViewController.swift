//
//  AddViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit
import SeSACKit

protocol PassDateDelegate: AnyObject { // 프로토콜의 값 전달 (1)
    func receiveDate(date: Date)
}

protocol PassImageDelegate: AnyObject {
    func receiveImage(image: UIImage)
}

final class AddViewController: BaseViewController {
    
    private let mainView = AddView()
    
    // viewDidLoad보다 먼저 호출됨 -> super 메서드 호출 X
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // APIService.shared.callRequest()
        
        // open & public -> 모듈로 접근 가능
        // ClassOpenExample.publicFunction()
        // ClassPublicExample.publicFunction()
        
        // internal -> 모듈로 접근 불가
        // ClassInternalExample.publicFunction() // Cannot find 'ClassInternalExample' in scope
    }
    
    deinit { // 소멸자
        print("deinit", self)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver(notification:)),
            name: .selectImage,
            object: nil
        )
        
        // sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(
            self,
            name: .selectImage,
            object: nil
        )
    }
    
    override func showAlert(title: String, message: String, topButton: String, bottomButton: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let galleryButton = UIAlertAction(title: topButton, style: .default)
        let webButton = UIAlertAction(title: bottomButton, style: .default) { action in
            self.navigationController?.pushViewController(
                SearchViewController(),
                animated: true
            )
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(galleryButton)
        alert.addAction(webButton)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc
    func selectImageNotificationObserver(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc
    func searchButtonClicked() {
        showAlert(title: "어떤 것을 검색하시겠습니까?", message: "선택하세요", topButton: "갤러리에서 가져오기", bottomButton: "웹에서 검색하기")
//        let words = ["A", "B", "C", "D", "E"]
//        NotificationCenter.default.post(
//            name: NSNotification.Name("RecommandKeyword"),
//            object: nil,
//            userInfo: [
//                "word": words.randomElement()!
//            ]
//        )
//        navigationController?.pushViewController(
//            SearchViewController(),
//            animated: true
//        )
    }
    
    @objc
    func dateButtonClicked() {
//        let vc = DateViewController() // 프로토콜의 값 전달 (5)
//        vc.delegate = self
        let vc = HomeViewController() // 실습을 위해 임시로 변경
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
    
    @objc
    func searchProtocolButtonClicked() {
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc
    func titleButtonClicked() {
        let vc = TitleViewController()
        vc.completionHandler = { text, age, isPushed in
            self.mainView.titleButton.setTitle(text, for: .normal)
            print(age, isPushed)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func contentButtonClicked() {
        let vc = TitleViewController()
        vc.completionHandler = { text, age, isPushed in
            self.mainView.contentButton.setTitle(text, for: .normal)
            print(age, isPushed)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func webButtonClicked() {
        let vc = WebViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.searchButton.addTarget(
            self,
            action: #selector(searchButtonClicked),
            for: .touchUpInside
        )
        mainView.dateButton.addTarget(
            self,
            action: #selector(dateButtonClicked),
            for: .touchUpInside
        )
        mainView.searchProtocolButton.addTarget(
            self,
            action: #selector(searchProtocolButtonClicked),
            for: .touchUpInside
        )
        mainView.titleButton.addTarget(
            self,
            action: #selector(titleButtonClicked),
            for: .touchUpInside
        )
        mainView.contentButton.addTarget(
            self,
            action: #selector(contentButtonClicked),
            for: .touchUpInside
        )
        
        mainView.webButton.addTarget(
            self,
            action: #selector(webButtonClicked),
            for: .touchUpInside
        )
        
        // APIService.shared.callRequest() // Shared Session
        
        // 잘못된 방식
        // APIService() // 이렇게 인스턴스를 만드는 일은 없어야 한다 -> 의도적으로 사용을 방지해야 함 -> private init()
    }
}

extension AddViewController: PassDateDelegate {  // 프로토콜의 값 전달 (4)
    func receiveDate(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}

//MARK: PassImageDelegate
extension AddViewController: PassImageDelegate {
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }
}
