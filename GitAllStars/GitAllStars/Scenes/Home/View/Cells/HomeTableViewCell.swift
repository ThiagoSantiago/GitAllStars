//
//  HomeTableViewCell.swift
//  GitAllStars
//
//  Created by Thiago Santiago on 2/21/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    var repoName: UILabel!
    var starLabel: UILabel!
    var starImage: UIImageView!
    var repoImage: UIImageView!
    var repoAuthorName: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func createViews() {
        
        repoImage = UIImageView()
        repoImage.image = UIImage(named: "placeholder")
        repoImage.clipsToBounds = true
        repoImage.layer.cornerRadius = 30
        repoImage.contentMode = .scaleAspectFit
        repoImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.repoImage)
        
        repoName = UILabel()
        repoName.textColor = UIColor.black
        repoName.font = UIFont.boldSystemFont(ofSize: 17)
        repoName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.repoName)
        
        repoAuthorName = UILabel()
        repoAuthorName.textColor = UIColor.lightGray
        repoAuthorName.font = UIFont.systemFont(ofSize: 15)
        repoAuthorName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.repoAuthorName)
        
        starImage = UIImageView()
        starImage.clipsToBounds = true
        starImage.contentMode = .scaleAspectFit
        starImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.starImage)
        
        starLabel = UILabel()
        starLabel.textColor = UIColor.black
        starLabel.font = UIFont.systemFont(ofSize: 14)
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.starLabel)
        
        setViewsConstraint()
    }
    
    private func setViewsConstraint() {
        
        repoImage.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.height.equalTo(60)
            make.centerY.equalTo(self.contentView)
        }
        
        repoName.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.height.equalTo(20)
            make.left.equalTo(repoImage.snp.right).offset(10)
            make.right.greaterThanOrEqualTo(self.contentView).offset(-10)
        }
        
        repoAuthorName.snp.makeConstraints { (make) in
            make.height.equalTo(17)
            make.top.equalTo(repoName.snp.bottom).offset(4)
            make.left.equalTo(repoImage.snp.right).offset(10)
            make.right.greaterThanOrEqualTo(self.contentView).offset(-10)
        }
        
        starImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
        }
        
        starLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.centerY.equalTo(starImage.snp.centerY)
            make.right.equalTo(starImage.snp.left).offset(-10)
        }
    }
    
    public func setContent(){
        repoName.text = "Repo name"
        repoAuthorName.text = "Repo author name"
        starLabel.text = "99999999"
    }
}
