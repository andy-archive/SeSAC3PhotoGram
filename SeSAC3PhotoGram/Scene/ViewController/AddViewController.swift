//
//  AddViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit

final class AddViewController: BaseViewController {
    
    private let mainView = AddView()
    
    // viewDidLoad보다 먼저 호출됨 -> super 메서드 호출 X
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectImageNotificationObserver(notification:)),
            name: NSNotification.Name("SelectImage"),
            object: nil
        )
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        let words = ["A", "B", "C", "D", "E"]
        
        NotificationCenter.default.post(
            name: NSNotification.Name("RecommandKeyword"),
            object: nil,
            userInfo: [
                "word": words.randomElement()!
            ]
        )
        present(SearchViewController(), animated: true)
    }
    
    override func configureView() {
        super.configureView()
        mainView.searchButton.addTarget(
            self,
            action: #selector(searchButtonClicked),
            for: .touchUpInside
        )
    }
    
}
