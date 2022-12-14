//
//  BookTableViewCell.swift
//  BookSearch
//
//  Created by 강휘 on 2022/11/30.
//

import Foundation
import UIKit


class BookTableViewCell : UITableViewCell {
    static let identifier = "BookTableViewCell"
    private var isbn: String = ""
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2

        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    let priceLabel = UILabel()
    
    let bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let isbnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    let urlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    func configure(book: Book) {
        titleLabel.text = book.title
        subTitleLabel.text = book.subtitle
        priceLabel.text = book.price
        setISBN(book.isbn13)
        urlLabel.text = book.url
        bookImage.setImage(url: book.image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImage.image = UIImage(named: "placeholder")
    }
    
    public func setISBN(_ value: String) {
        isbn = value
        isbnLabel.text = value
    }
    
    public func getISBN() -> String {
        return isbn
    }
    
    private func setUI() {
        [titleLabel,subTitleLabel,priceLabel,bookImage,isbnLabel,urlLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: Layout.tableViewCellHeight),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: Layout.tableViewCellTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor),
            
            isbnLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            isbnLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor),
            
            urlLabel.bottomAnchor.constraint(equalTo: isbnLabel.topAnchor),
            urlLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor),
            
            
        ])

    }
      
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
      
}
