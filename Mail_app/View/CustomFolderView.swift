//
//  CustomFolderView.swift
//  Mail_app
//
//  Created by praveen mack on 04/09/21.
//

import UIKit

protocol CustomFolderViewDelegate: class {
    func didFilterTapped(filterName: String)
}

class CustomFolderView: UIView {
    
    // MARK: - Properties
    
    let folderArr = [ "CustomFolder" ,  "Starred" , "Inbox" , "Events" , "Saved"]
    
    weak var delegate: CustomFolderViewDelegate?
    
    let divider1: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delegate = self
        cv.dataSource = self
        cv.register(FoldersCollectionViewCell.self, forCellWithReuseIdentifier: "FoldersCollectionViewCell")
        cv.backgroundColor = Constants.AppColor
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return cv
    }()
    
    let divider2: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        return v
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper function
    
    func setUpViews(){
        addSubview(divider1)
        addSubview(divider2)
        addSubview(collectionView)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            divider1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            divider1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            divider1.heightAnchor.constraint(equalToConstant: 0.7),
            divider1.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: divider1.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: divider2.topAnchor),
            
            divider2.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 0.7),
            divider2.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension CustomFolderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folderArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoldersCollectionViewCell", for: indexPath) as! FoldersCollectionViewCell
        cell.folderImage.image = UIImage(named: folderArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didFilterTapped(filterName: folderArr[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedWidth = (collectionView.frame.width - 20) / 5
        return CGSize(width: estimatedWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
