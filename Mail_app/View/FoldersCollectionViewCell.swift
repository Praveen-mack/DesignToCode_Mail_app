//
//  FoldersCollectionViewCell.swift
//  Mail_app
//
//  Created by praveen mack on 04/09/21.
//

import UIKit

class FoldersCollectionViewCell: UICollectionViewCell {
    
    // MARK:- properties
    
    override var isSelected: Bool {
        didSet {
            folderImage.tintColor = isSelected ? Constants.AppBlue : Constants.AppIconColor
            folderImage.backgroundColor = isSelected ? Constants.AppLightBlue : .clear
            folderImage.transform = isSelected ? .init(scaleX: 1.3, y: 1.3) : .identity
        }
    }
    
    let folderImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = Constants.AppIconColor
        img.layer.cornerRadius = 10
        return img
    }()

    
    // MARK:- Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- helper function
    
    func setUpViews(){
        addSubview(folderImage)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            folderImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            folderImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            folderImage.heightAnchor.constraint(equalToConstant: 20),
            folderImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
