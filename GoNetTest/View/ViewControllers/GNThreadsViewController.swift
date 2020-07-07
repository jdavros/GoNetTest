//
//  GNThreadsViewController.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 06/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

class GNThreadsViewController: UIViewController {
    
    let threadsTableView = UITableView()
    let reuseID = "ThreadsCell"
    var threads = [String]()
    
    let threadA = BlockOperation()
    let threadB = BlockOperation()
    let threadC = BlockOperation()
    let threadsOperationQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    private func configure() {
        threadsTableView.delegate = self
        threadsTableView.dataSource = self
        threadsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
        setUILayout()
    }
    
    private func setUILayout() {
        view.addSubviews(threadsTableView)
        threadsTableView.translatesAutoresizingMaskIntoConstraints = false
        threadsTableView.pinToEdges(of: view)
    }
    
    func cleanAction() {
        threadsOperationQueue.cancelAllOperations()
        threads.removeAll()
        threadsTableView.reloadData()
    }
    
    func startAction() {
        configureThreads()
        executeOperations()
    }
    
    private func configureThreads() {
        threadA.queuePriority = .low
        threadB.queuePriority = .normal
        threadC.queuePriority = .high
        threadC.addDependency(threadB)
    }
    
    private func executeOperations() {
        threadA.addExecutionBlock {
            for index in 1...1000 {
                self.threadsOperationQueue.addBarrierBlock {
                    self.threads.append("Hilo A | prioridad baja | valor \(index)")
                    DispatchQueue.main.async {
                        self.threadsTableView.reloadData()
                    }
                }
            }
        }
        threadB.addExecutionBlock {
            for index in 1...1000 {
                self.threadsOperationQueue.addBarrierBlock {
                    self.threads.append("Hilo B | prioridad media | valor \(index)")
                    DispatchQueue.main.async {
                        self.threadsTableView.reloadData()
                    }
                }
            }
        }
        threadC.addExecutionBlock {
            for index in 1...1000 {
                self.threadsOperationQueue.addBarrierBlock {
                    self.threads.append("Hilo C | prioridad alta  | valor \(index)")
                    DispatchQueue.main.async {
                        self.threadsTableView.reloadData()
                    }
                }
            }
        }
        threadsOperationQueue.addOperations([threadA, threadB, threadC], waitUntilFinished: false)
    }
}

extension GNThreadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.textLabel?.text = threads[indexPath.row]
        return cell
    }
    
    
}
