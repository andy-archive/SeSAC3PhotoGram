//
//  URLSession.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/31.
//

import UIKit

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func customDataTask(_ endpoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: completionHandler)
        task.resume()
        return task
    }
}
