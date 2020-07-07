//
//  GNDescriptionLabel.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 05/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

class GNDescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure() {
        textColor                   = .label
        lineBreakMode               = .byWordWrapping
        numberOfLines               = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
