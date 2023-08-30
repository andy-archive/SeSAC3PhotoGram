//
//  APIService.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/30.
//

import Foundation

class APIService {
    
    private init() {} // 생성자 구문을 클래스 안에서만 쓸 수 있게 접근 제어
    
    static let shared = APIService() // 인스턴스 생성 방지
    
    func callRequest() {
        
//        guard let url = URL(string: "www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080") else { return }
        guard let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            print(data)
//            let value = String(data: data!, encoding: .utf8)
//            print("VALUE: \(value)")
            
            print(response)
            print(error)
            
            
        }.resume()
    }
}
