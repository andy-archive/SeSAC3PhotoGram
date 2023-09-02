//
//  DateViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/29.
//

import UIKit

final class DateViewController: BaseViewController {
    
    private let mainView = DateView()
    
    weak var delegate: PassDateDelegate? // 프로토콜의 값 전달 (2)
    
    override func loadView() {
        self.view = mainView
    }
    
    deinit { // 소멸자
        print("deinit", self)
    }
    
    override func viewDidDisappear(_ animated: Bool) { // 프로토콜의 값 전달 (3)
        super.viewDidDisappear(animated)
        
        delegate?.receiveDate(date: mainView.picker.date) // 시키기만 함
    }
    
}
