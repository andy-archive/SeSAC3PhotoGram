//
//  HomeViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/31.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    var list: Photo = Photo(total: 0, totalPages: 0, results: [])
    private let mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        APIService.shared.callRequest(query: "sky") { photo in
            guard let photo = photo else {
                print("ALERT ERROR")
                return
            }
            self.list = photo // 네트워크 전후로 데이터가 변경됨
            self.mainView.collectionView.reloadData()
        }
    }
    
    deinit {
        print(self, #function)
    }
}

//MARK: UICollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .systemGray
        
        let thumb = list.results[indexPath.item].urls.thumb

        // 링크를 기반으로 이미지를 보여주는 것은 결국 네트워크 통신이다
        guard let url = URL(string: thumb) else { return UICollectionViewCell() }

        DispatchQueue.global().async { // 네트워크 통신은 global async
            guard let data = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async { // UI는 다시 main async
                cell.imageView.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
//        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}

//MARK: HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    
    func didSelectItemAt(indexPath: IndexPath) {
//        print("extension HomeViewController: HomeViewProtocol", #function, indexPath)
//        navigationController?.popViewController(animated: true)
    }
}
