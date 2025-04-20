//
//  PostTableViewCell.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "postIcon")
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
        
    }()
    
    func setup(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Erro ao carregar a celula")
    }
}

extension PostTableViewCell: ViewCodable {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(postImage)
    }
    
    func buildViewConstraints() {
        postImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(postImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.trailing.equalTo(descriptionLabel.snp.trailing).offset(-10.0)
        }
    }
    
    func additionalConfig() {
        self.backgroundColor = .white
    }
}
