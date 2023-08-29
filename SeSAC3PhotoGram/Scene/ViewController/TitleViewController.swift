//
//  TitleViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력하세요"
        return view
    }()
    
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(doneButtonClicked)
        )
    }
    
    @objc func doneButtonClicked() {
        
        guard let inputText = textField.text else { return }
        completionHandler?(inputText, 30, false)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let inputText = textField.text else { return }
        
        completionHandler?(inputText, 897, true)
        
    }
}
