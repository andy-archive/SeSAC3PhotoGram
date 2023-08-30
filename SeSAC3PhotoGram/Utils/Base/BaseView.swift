//
//  BaseView.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) { // 스토리보드 상 실행 -> 코드베이스에서는 실행이 되지 않음
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {}
    
    func setConstraints() {}
}
