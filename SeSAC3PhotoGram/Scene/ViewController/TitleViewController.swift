//
//  TitleViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/29.
//

import UIKit

final class TitleViewController: BaseViewController {
    
    private let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력하세요"
        return view
    }()
    
    private let redView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let orangeView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let yellowView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    private let greenView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    deinit { // 소멸자
        print("deinit", self)
    }
    
    private func setAnimation() {
        // Animation Start UI
        redView.alpha = 0.1
            
        [orangeView, yellowView, greenView].forEach {
            $0.alpha = 0
        }
        
        // Animation End UI
        UIView.animate(withDuration: 1, delay: 0.5, options: [.curveEaseOut, .curveLinear]) {
            self.redView.alpha = 1
            self.redView.backgroundColor = .systemRed
            self.redView.layer.borderColor = UIColor.black.cgColor
            self.redView.layer.borderWidth = 1
            self.orangeView.alpha = 0.1
        } completion: { bool in
            UIView.animate(withDuration: 1, delay: 0.5, options: [.transitionFlipFromLeft]) {
                self.orangeView.backgroundColor = .systemOrange
                self.orangeView.alpha = 1
                self.yellowView.alpha = 0.1
            } completion: { bool in
                UIView.animate(withDuration: 1, delay: 0.5, options: [.curveLinear]) {
                    self.yellowView.backgroundColor = .systemYellow
                    self.yellowView.alpha = 1
                    self.greenView.alpha = 0.1
                } completion: { bool in
                    UIView.animate(withDuration: 1, delay: 0.5, options: [.transitionCrossDissolve]) {
                        self.greenView.backgroundColor = .systemGreen
                        self.greenView.alpha = 1
                    }
                }
            }
        }

        UIView.animate(withDuration: 1) {
            self.redView.alpha = 1
        }
    }
    
    @objc
    func doneButtonClicked() {
        guard let inputText = textField.text else { return }
        completionHandler?(inputText, 30, false)
        
        navigationController?.popViewController(animated: true)
    }
    
    override func configureView() {
        super.configureView()
        
        [textField, redView, orangeView, yellowView, greenView].forEach {
            view.addSubview($0)
        }
        
        setAnimation()
        setNavigationBar()
    }
    
    override func setConstraints() {
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        redView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        orangeView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalTo(redView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        yellowView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalTo(redView.snp.bottom).offset(10)
            make.trailing.equalTo(orangeView.snp.leading).offset(-10)
        }
        
        greenView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerY.equalTo(view)
            make.trailing.equalTo(redView.snp.leading).offset(-10)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let inputText = textField.text else { return }
        
        completionHandler?(inputText, 897, true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.orangeView.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.orangeView.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.orangeView.alpha = 0.5
            UIView.animate(withDuration: 0.3) {
                self.orangeView.alpha = 1.0
            }
        }
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(doneButtonClicked)
        )
    }
}
