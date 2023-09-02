//
//  URLSessionViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/30.
//

import UIKit
import SnapKit

final class URLSessionViewController: BaseViewController {
    
    var session: URLSession!
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(String(format: "%.1f", result * 100))%"
        }
    }
    
    private let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        return view
    }()
    
    private let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data()

        let url = "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg"
        guard let url = URL(string: url) else { return }
        
        // 새로 배우는 delegate 방식
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main) // main 스레드에서 작동하도록 구현되어 있다
        session.dataTask(with: url).resume()
         
        // 기존의 completionHandler를 이용한 closure 방식
        // session.dataTask(with: <#T##URLRequest#>).resume()
        // URLSession.shared.dataTask(with: <#T##URLRequest#>) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
        //     <#code#>
        // }
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(imageView)
        view.addSubview(progressLabel)
    }
    
    override func setConstraints() {
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 취소 액션 - 화면이 사라질 때
        // 리소스 정리 & 실행 중인 것도 무시
        session.invalidateAndCancel()
        
        // 기다렸다가 리소스가 끝나면 정리
        session.finishTasksAndInvalidate()
    }
}

// MARK: URLSessionDelegate

extension URLSessionViewController: URLSessionDataDelegate {
    
    // (1) 서버에서 최초로 응답 받은 경우에 호출 - 상태 코드 처리
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPONSE :", response)
        
        if let response = response as? HTTPURLResponse,
           (200...500).contains(response.statusCode) {
            
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!) ?? 0
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    // (2) 서버에서 데이터를 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA: ", data)
        buffer?.append(data)
    }
    
    // (3) 서버에서 응답이 완료된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
        
        if let error {
            print(error)
        } else {
            guard let buffer = buffer else { return }
            imageView.image = UIImage(data: buffer)
        }
    }
}
