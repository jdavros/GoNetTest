//
//  GNImageView.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 05/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

class GNImageView: UIImageView {
    
    let placeholderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        contentMode         = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
