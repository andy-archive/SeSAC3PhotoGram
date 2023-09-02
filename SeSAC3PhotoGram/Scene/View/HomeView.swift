//
//  HomeView.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/31.
//

import UIKit

final class HomeView: BaseView {
    
    weak var delegate: HomeViewProtocol?
    
    lazy var collectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: .setCollectionViewLayout(numberOfItem: 3, sectionSpacing: 8, itemSpacing: 20)
        )
        view.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: "SearchCollectionViewCell"
        )
        return view
    }()
    
    override func configureView() {
        super.configureView()
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

