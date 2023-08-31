//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    weak var delegate: PassImageDelegate?
    
    var imageList = [Photo]()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addObserver보다 post가 먼저 신호를 보내면 작동하지 않는다
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(recommandKeywordNotificationObserver(notification:)),
            name: NSNotification.Name("RecommandKeyword"),
            object: nil
        )
        
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
    
    deinit { // 소멸자
        print("deinit", self)
    }
    
    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
        print(#function)
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

//MARK: SearchCollectionView & SearchCollectionViewCell

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SearchCollectionViewCell",
            for: indexPath
        ) as? SearchCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
//        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.item])!)
        
//        NotificationCenter.default.post(
//            name: NSNotification.Name("SelectImage"),
//            object: nil,
//            userInfo: [
//                "name": imageList[indexPath.item],
//                "nickname": "Andy"
//            ]
//        )
        dismiss(animated: true)
    }
    
}

//MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.searchBar.resignFirstResponder() // 현재 FirstResponder를 포기해
    }
}
