//
//  AddView.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit

final class AddView: BaseView {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .systemTeal
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let searchProtocolButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let contentButton = {
        let view = UIButton()
        view.backgroundColor = .brown
        view.setTitle("컨텐츠", for: .normal)
        return view
    }()
    
    let webButton = {
        let view = UIButton()
        view.backgroundColor = .systemIndigo
        view.setTitle("애플 홈페이지로 이동", for: .normal)
        return view
    }()
    
    override func configureView() {
        [photoImageView, searchButton, dateButton, searchProtocolButton, titleButton, contentButton, webButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        searchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.leading.equalTo(photoImageView)
        }
        
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        contentButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        
        webButton.snp.makeConstraints { make in
            make.top.equalTo(contentButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
    }
}
