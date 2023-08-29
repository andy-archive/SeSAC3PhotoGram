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

}
