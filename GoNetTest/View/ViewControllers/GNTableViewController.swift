//
//  GNTableViewController.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 06/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

class GNTableViewController: UIViewController {

    let tableView = UITableView()
    var tableData: [DummyData]
    
    init() {
        let mainVM = MainViewModel()
        self.tableData = mainVM.getDummyData(with: 6)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        layoutTableViewUIComponent()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(GNTableViewCell.self, forCellReuseIdentifier: GNTableViewCell.reuseID)
    }
    
    private func layoutTableViewUIComponent() {
        view.addSubview(tableView)
        tableView.pinToEdges(of: view)
    }

}

extension GNTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GNTableViewCell.reuseID, for: indexPath) as! GNTableViewCell
        cell.set(data: tableData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = tableData[indexPath.row]
        let descriptionViewController = DescriptionViewController(selectedData: selectedData)
        self.present(descriptionViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
