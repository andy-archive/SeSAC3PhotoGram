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
    
    func callRequest(query: String, completionHandler: @escaping (Photo?) -> Void) {
        
//        guard let url = URL(string: "www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080") else { return }
//        guard let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg") else { return }
        guard let url = URL(string: "https://api.unsplash.com/search/photos/?query=\(query)&client_id=\(APIKey.unsplashAccess)") else { return }
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // global 스레드에서 동작
        URLSession.shared.dataTask(with: request) { data, response, error in

            //let value = String(data: data!, encoding: .utf8)
            //print("VALUE: \(value)")
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else {
                    completionHandler(nil)
                    return
                }
                
//                print(response.statusCode)
                
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
//                print(String(data: data, encoding: .utf8))
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                } catch { // catch 문을 통해 디코딩 오류를 잡을 수 있다
                    print(error)
                    completionHandler(nil)
                }
            }
        }.resume()
    }
}
