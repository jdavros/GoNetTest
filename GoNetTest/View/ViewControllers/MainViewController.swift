//
//  MainViewController.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 04/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let controlsContainerView = UIView()
    let segmentedControl = UISegmentedControl(items: ["Table", "Threads"])
    let cleanButton = UIButton()
    let startButton = UIButton()
    let tableContainerView = UIView()
    
    var threadControlsHeightConstraint: NSLayoutConstraint!
    
    let gnTableViewController = GNTableViewController()
    let gnThreadsViewController = GNThreadsViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideThreadsControls()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        configureViews()
    }
    
    private func configureViews() {
        controlsContainerView.backgroundColor = .secondarySystemBackground
        tableContainerView.backgroundColor = .systemBackground
        cleanButton.setTitle("Clean", for: .normal)
        startButton.setTitle("Start", for: .normal)
        cleanButton.setTitleColor(.label, for: .normal)
        startButton.setTitleColor(.label, for: .normal)
        cleanButton.addTarget(self, action: #selector(handleCleanButtonAction), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(handleStartButtonAction), for: .touchUpInside)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleSegmentedControlAction), for: .valueChanged)
    }
    
    private func layoutUI() {
        layoutSegmentedControlUIComponent()
        layoutControlsUIComponents()
        layoutTableContainerView()
        showTableView(withOption: self.segmentedControl.selectedSegmentIndex)
    }
    
    private func layoutSegmentedControlUIComponent() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func layoutControlsUIComponents() {
        view.addSubview(controlsContainerView)
        controlsContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        controlsContainerView.addSubview(cleanButton)
        controlsContainerView.addSubview(startButton)
        cleanButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        threadControlsHeightConstraint = controlsContainerView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            controlsContainerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            controlsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            threadControlsHeightConstraint,
            
            startButton.trailingAnchor.constraint(equalTo: controlsContainerView.trailingAnchor, constant: -20),
            startButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor),
            
            cleanButton.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -30),
            cleanButton.centerYAnchor.constraint(equalTo: startButton.centerYAnchor)
            
        ])
    }
    
    private func layoutTableContainerView() {
        view.addSubview(tableContainerView)
        tableContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableContainerView.topAnchor.constraint(equalTo: controlsContainerView.bottomAnchor),
            tableContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func handleSegmentedControlAction() {
        let selectedOption = segmentedControl.selectedSegmentIndex == 1 ? true : false
        toggleThreadsControls(selectedOption)
    }
    
    @objc private func handleCleanButtonAction() {
        gnThreadsViewController.cleanAction()
    }
    
    @objc private func handleStartButtonAction() {
        gnThreadsViewController.startAction()
    }
    
    private func toggleThreadsControls(_ showControls: Bool) {
        UIView.animate(withDuration: 0.3) {
            let controlsContainerHeight:CGFloat = showControls ? 50 : 0
            self.cleanButton.isHidden = !showControls
            self.startButton.isHidden = !showControls
            self.threadControlsHeightConstraint.constant = controlsContainerHeight
            self.showTableView(withOption: self.segmentedControl.selectedSegmentIndex)
            self.view.layoutIfNeeded()
        }
    }
    
    private func showTableView(withOption option: Int) {
        if option < 1 {
            gnThreadsViewController.view.removeFromSuperview()
            gnThreadsViewController.removeFromParent()
            self.addChild(gnTableViewController)
            tableContainerView.addSubview(gnTableViewController.view)
            gnTableViewController.view.pinToEdges(of: tableContainerView)
        } else {
            gnTableViewController.view.removeFromSuperview()
            gnTableViewController.removeFromParent()
            self.addChild(gnThreadsViewController)
            tableContainerView.addSubview(gnThreadsViewController.view)
            gnThreadsViewController.view.pinToEdges(of: tableContainerView)
        }
    }
    
    private func hideThreadsControls() {
        cleanButton.isHidden = true
        startButton.isHidden = true
    }

}
