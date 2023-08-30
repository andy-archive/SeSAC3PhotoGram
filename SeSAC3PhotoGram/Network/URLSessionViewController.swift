//
//  URLSessionViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/30.
//

import UIKit

class URLSessionViewController: UIViewController {
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") else { return }
        
        // 새로 배우는 delegate 방식
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume()
         
        // 기존의 completionHandler를 이용한 closure 방식
        // session.dataTask(with: <#T##URLRequest#>).resume()
        // URLSession.shared.dataTask(with: <#T##URLRequest#>) { <#Data?#>, <#URLResponse?#>, <#Error?#> in
        //     <#code#>
        // }
    }
}

// MARK: URLSessionDelegate

extension URLSessionViewController: URLSessionDataDelegate {
    
    // (1) 서버에서 최초로 응답 받은 경우에 호출 - 상태 코드 처리
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//        print("RESPONSE :", response)
//    }
    
    // (2) 서버에서 데이터를 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA: ", data)
    }
    
    // (3) 서버에서 응답이 완료된 이후에 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
    }
}
