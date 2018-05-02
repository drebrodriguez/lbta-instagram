//
//  UserProfileHeader.swift
//  lbta-instagram
//
//  Created by Dreb Rodriguez on 02/05/2018.
//  Copyright © 2018 Joash Tubaga. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            setupProfileImage()
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 80/2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    let gridButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return btn
    }()
    
    let listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    let bookmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.2)
        return btn
    }()
    
    let postLabel: UILabel = {
        let lbl = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor:UIColor.lightGray]))
        lbl.attributedText = attributedText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let followersLabel: UILabel = {
        let lbl = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor:UIColor.lightGray]))
        lbl.attributedText = attributedText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let followingLabel: UILabel = {
        let lbl = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor:UIColor.lightGray]))
        lbl.attributedText = attributedText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let editProfileButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [profileImageView, usernameLabel, editProfileButton].forEach {addSubview($0)}
        
        profileImageView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, paddingTop: 12, paddingBottom: 12, paddingLeft: 12, paddingRight: 12, width: 80, height: 80)
        
        usernameLabel.anchor(top: profileImageView.bottomAnchor, bottom: nil, left: nil, right: nil, paddingTop: 12, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        usernameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        
        setupUserStats()
        
        editProfileButton.anchor(top: postLabel.bottomAnchor, bottom: nil, left: postLabel.leftAnchor, right: followingLabel.rightAnchor, paddingTop: 4, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 34)
        
        setupBottomToolbar()
    }
    
    fileprivate func setupUserStats() {
        let stackview: UIStackView = {
            let sv = UIStackView(arrangedSubviews: [postLabel,followersLabel,followingLabel])
            sv.distribution = .fillEqually
            return sv
        }()
        
        addSubview(stackview)
        stackview.anchor(top: topAnchor, bottom: nil, left: profileImageView.rightAnchor, right: rightAnchor, paddingTop: 12, paddingBottom: 0, paddingLeft: 12, paddingRight: 12, width: 0, height: 50)
    }
    
    fileprivate func setupBottomToolbar() {
        let stackview: UIStackView = {
            let sv = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
            sv.distribution = .fillEqually
            return sv
        }()
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        [stackview,topDividerView,bottomDividerView].forEach{addSubview($0)}

        stackview.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 50)
        
        stackview.separatorLines(bgColor: .lightGray, height: 0.5)
    }
    
    fileprivate func setupProfileImage() {
        guard  let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let error = err {
                print("Failed to fetch Pofile Image: ", error)
                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
