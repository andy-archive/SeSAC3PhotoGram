//
//  BaseViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
    }
    
    func showAlert(title: String, message: String, topButton: String, bottomButton: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let button = UIAlertAction(title: topButton, style: .default)
        let button2 = UIAlertAction(title: bottomButton, style: .default)
        let cancel = UIAlertAction(title: "취소", style: .default)
        alert.addAction(button)
        alert.addAction(button2)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
