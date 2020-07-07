//
//  GNTableViewCell.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 05/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

class GNTableViewCell: UITableViewCell {
    
    static let reuseID      = "GNCell"
    let cellImageView       = GNImageView(frame: .zero)
    let titleLabel          = GNTitleLabel(textAlignment: .left, fontSize: 20)
    let descriptionLabel    = GNDescriptionLabel(textAlignment: .justified, fontSize: 14)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: DummyData) {
        cellImageView.image = data.image
        titleLabel.text = data.title
        descriptionLabel.text = data.description        
    }
    
    private func configure() {
        addSubviews(cellImageView, titleLabel, descriptionLabel)
                
        let padding: CGFloat    = 10
        
        NSLayoutConstraint.activate([            
            cellImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            cellImageView.widthAnchor.constraint(equalToConstant: 60),
            cellImageView.heightAnchor.constraint(equalToConstant: 60),
            cellImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
    

}
