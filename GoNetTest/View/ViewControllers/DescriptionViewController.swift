//
//  DescriptionViewController.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 06/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    let imageView: GNImageView
    let titleLabel: GNTitleLabel
    let descriptionLabel: GNDescriptionLabel
    
    var portraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    var currentOrientation: UIInterfaceOrientation?
    
    let selectedData: DummyData
    
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    init(selectedData: DummyData) {
        self.selectedData = selectedData
        imageView = GNImageView(frame: .zero)
        imageView.image = selectedData.image
        titleLabel = GNTitleLabel(textAlignment: .center, fontSize: 20)
        descriptionLabel = GNDescriptionLabel(textAlignment: .justified, fontSize: 14)
        titleLabel.text = selectedData.title
        descriptionLabel.text = selectedData.description
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        portraitConstraints = getPortraitConstraints()
        landscapeConstraints = getLandscapeConstraints()
        configure()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }
            UIView.animate(withDuration: 0.3) {
                self.handleOrientationChange(orientation: windowInterfaceOrientation)
            }
        }
    }
    
    private func configure() {
        view.addSubviews(imageView, titleLabel, descriptionLabel)
        NSLayoutConstraint.activate(portraitConstraints)
    }
    
    private func handleOrientationChange(orientation: UIInterfaceOrientation) {
        if orientation == .portrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        } else {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
        view.layoutIfNeeded()
    }
    
    private func getPortraitConstraints() -> [NSLayoutConstraint] {
        let padding: CGFloat = 20
        let imageViewDimension: CGFloat = 200
        return [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageViewDimension),
            imageView.heightAnchor.constraint(equalToConstant: imageViewDimension),

            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
    }
    
    private func getLandscapeConstraints() -> [NSLayoutConstraint]  {
        let padding: CGFloat = 20
        let imageViewDimension: CGFloat = 200
                
        return [
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageViewDimension),
            imageView.heightAnchor.constraint(equalToConstant: imageViewDimension),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 100),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
    }

}
