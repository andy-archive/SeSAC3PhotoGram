//
//  SearchView.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/28.
//

import UIKit

final class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력하세요"
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        view.collectionViewLayout = setCollectionViewLayout()
        return view
    }()
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 60 // self.frame.width - 40
        layout.itemSize = CGSize(width: size / 6, height: size / 6)
        return layout
    }
}
