//
//  HomeViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/31.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    override func loadView() {
        let view = HomeView()
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
    }
    
    deinit {
        print(self, #function)
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func didSelectItemAt(indexPath: IndexPath) {
        print("extension HomeViewController: HomeViewProtocol", #function, indexPath)
        navigationController?.popViewController(animated: true)
    }
}
