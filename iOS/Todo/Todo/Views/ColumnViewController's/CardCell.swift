//
//  CardCell.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/07.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class CardCell: UITableViewCell, ReusableView {
    private let formatImageView = FormatImageView(frame: .zero)
    private let titleLabel = CardTitleLabel()
    private let contentLabel = ContentLabel()
    private let authorLabel = AuthorLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configure() {
        configureFormatImageView()
        configureTitle()
        configureContext()
        configureDetailText()
    }
    
    private func configureFormatImageView() {
        contentView.addSubview(formatImageView)
        
        let constant: CGFloat = 10
        formatImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant).isActive = true
        formatImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant).isActive = true
    }
    
    private func configureTitle() {
        contentView.addSubview(titleLabel)
        
        let constant: CGFloat = 10
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant: constant).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant).isActive = true
    }
    
    private func configureContext() {
        contentView.addSubview(contentLabel)
        
        let constant: CGFloat = 10
        contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: constant).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant: constant).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant).isActive = true
    }
    
    private func configureDetailText() {
        contentView.addSubview(authorLabel)
        
        let constant: CGFloat = 10
        authorLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: constant).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: formatImageView.trailingAnchor, constant:  constant).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant).isActive = true
        authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant).isActive = true
    }
    
    func configureTitle(text: String?) {
        titleLabel.text = text
    }
    func configureContent(text: String) {
        contentLabel.text = text
    }
    func configureAuthor(text: String) {
        authorLabel.text = text
    }
}

final class CardTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.boldSystemFont(ofSize: 15)
    }
}

final class ContentLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byWordWrapping
        numberOfLines = 3
    }
}

final class AuthorLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.boldSystemFont(ofSize: 12)
    }
}
