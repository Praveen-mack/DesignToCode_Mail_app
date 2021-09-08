//
//  MailListTableViewCell.swift
//  Mail_app
//
//  Created by praveen mack on 04/09/21.
//

import UIKit

class MainListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var data: MailData? {
        didSet {
            manageData()
        }
    }
    
    let userImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 17.5
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let userName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont(name: "Avenir", size: 16)
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return name
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.textAlignment = .right
        return label
    }()
    
    let subjectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 16)
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return label
    }()
    
    let moreImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "more")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let attachmentImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "attachment")
        img.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let starImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "star.filled")
        img.tintColor = Constants.AppYellow
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper function
    
    func setupViews() {
        addSubview(userImage)
        addSubview(userName)
        addSubview(timeLabel)
        addSubview(subjectLabel)
        addSubview(bodyLabel)
        addSubview(moreImage)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            userImage.widthAnchor.constraint(equalToConstant: 35),
            userImage.heightAnchor.constraint(equalToConstant: 35),
            
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 25),
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            userName.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -20),
            
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            
            subjectLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 25),
            subjectLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -20),
            subjectLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 3),
            
            bodyLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 25),
            bodyLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            bodyLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 3),
            
            moreImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.5),
            moreImage.widthAnchor.constraint(equalToConstant: 20),
            moreImage.heightAnchor.constraint(equalToConstant: 20),
            moreImage.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 28),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            stackView.widthAnchor.constraint(equalToConstant: 27),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25)
        ])
    }
    
    func manageData() {
        guard let data = data else { return }
        userName.text = data.userName
        timeLabel.text = data.time.uppercased()
        userImage.image = UIImage(named: data.userImage)
        subjectLabel.text = data.subject
        bodyLabel.text = data.body
        if data.isStarred {
            starImage.isHidden = false
            stackView.addArrangedSubview(starImage)
        } else {
            stackView.removeArrangedSubview(starImage)
            starImage.isHidden = true
        }
        if data.isAttachement {
            attachmentImage.isHidden = false
            stackView.addArrangedSubview(attachmentImage)
        } else {
            stackView.removeArrangedSubview(attachmentImage)
            attachmentImage.isHidden = true
        }
    }
}
