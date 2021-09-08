//
//  HomeViewController.swift
//  Mail_app
//
//  Created by praveen mack on 01/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    let titleLabel = UILabel()
    
    var dataArr = [
        MailData(userImage: "img1", userName: "Julie Andrews Stein", subject: "New week at the office", time: "23 min ago", body: "There are many variations of Lorem Ipsum text, but most have undergone changes, adding humor or confusing words that no longer seem believable.", isStarred: true, isAttachement: false),
        MailData(userImage: "img2", userName: "Alena Gomez", subject: "Hellooo!", time: "10.30", body: "There are many variations of Lorem Ipsum text, but most have undergone changes, adding humor or confusing words that no longer seem believable.", isStarred: true, isAttachement: true),
        MailData(userImage: "img3", userName: "Nike", subject: "All new sneakers!", time: "9.30", body: "There are many variations of Lorem Ipsum text, but most have undergone changes, adding humor or confusing words that no longer seem believable.", isStarred: true, isAttachement: false),
        MailData(userImage: "img4", userName: "Jonas Erikson", subject: "Newletter week 10", time: "Yesterday", body: "There are many variations of Lorem Ipsum text, but most have undergone changes, adding humor or confusing words that no longer seem believable.", isStarred: true, isAttachement: true),
        MailData(userImage: "img5", userName: "Dribbble", subject: "2 new Invites!", time: "25 Dec 2020", body: "There are many variations of Lorem Ipsum text, but most have undergone changes, adding humor or confusing words that no longer seem believable.", isStarred: false, isAttachement: false),
        MailData(userImage: "img6", userName: "Joseph Fernandez", subject: "XYZ - Invite to collaborate", time: "23 Dec 2020", body: "There are many variations of Lorem Ipsum text, but most have undergone changes, adding humor or confusing words that no longer seem believable.", isStarred: false, isAttachement: true)
    ]
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.tableFooterView = UIView()
        tv.backgroundColor = Constants.AppColor
        tv.delegate = self
        tv.dataSource = self
        tv.register(MainListTableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()
    
    lazy var folderView: CustomFolderView = {
        let v = CustomFolderView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Constants.AppColor
        v.delegate = self
        return v
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helper functions
    
    func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = Constants.AppColor

        // nav bar title
        titleLabel.text = "Inbox"
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 19)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 30)
        navigationItem.titleView = titleLabel
        
        // User image
        let userImage = UIImageView()
        userImage.image = #imageLiteral(resourceName: "demo")
        userImage.layer.cornerRadius = 10
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFill
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        userImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userImage)
        
        let rightBarButtonItem = UIBarButtonItem()
        rightBarButtonItem.customView = userImage
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
        // Menu Button
        let menuButton = UIButton()
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.imageView?.contentMode = .scaleAspectFill
        menuButton.tintColor = Constants.AppIconColor
        menuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        // Search Button
        let searchButton = UIButton()
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFill
        searchButton.tintColor = Constants.AppIconColor
        searchButton.frame = CGRect(x: 0, y: 0, width: 65, height: 25)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        let leftBarButtonItem1 = UIBarButtonItem()
        leftBarButtonItem1.customView = menuButton
        
        let leftBarButtonItem2 = UIBarButtonItem()
        leftBarButtonItem2.customView = searchButton
        
        navigationItem.setLeftBarButtonItems([leftBarButtonItem1, leftBarButtonItem2], animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = Constants.AppColor
        view.addSubview(folderView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            folderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            folderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            folderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            folderView.heightAnchor.constraint(equalToConstant: 70),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: folderView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainListTableViewCell
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.frame.width)
        cell.data = dataArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.alpha = 0
        UIView.animate(withDuration: 0.85, delay: 0.05 * Double(indexPath.row), usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseInOut, animations: {
            cell.transform = .identity
            cell.alpha = 1
        })
    }
}

extension HomeViewController: CustomFolderViewDelegate {
    func didFilterTapped(filterName: String) {
        titleLabel.text = filterName
        tableView.reloadData()
    }
}
