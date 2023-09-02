//
//  SearchViewController.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    weak var delegate: PassImageDelegate?
    let mainView = SearchView()
    var photoList: Photo = Photo(total: 0, total_pages: 0, results: [])
    
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
    
    @objc
    func recommandKeywordNotificationObserver(notification: NSNotification) {
        print(#function)
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

//MARK: Network - callRequest

extension SearchViewController {
    private func callRequest(query: String) {
        
        APIService.shared.callRequest(query: query) { photo in
            
            guard let photo = photo else { return }
            
            self.photoList = photo
            self.mainView.collectionView.reloadData()
        }
    }
}

//MARK: UICollectionView

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return photoList.results.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SearchCollectionViewCell",
            for: indexPath
        ) as? SearchCollectionViewCell
        else { return UICollectionViewCell() }
        
        let thumb = photoList.results[indexPath.item].urls.thumb
        
        guard let url = URL(string: thumb) else { return UICollectionViewCell() }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
//        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
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
        
        guard let text = mainView.searchBar.text else { return }
        
        self.callRequest(query: text)
    }
}
