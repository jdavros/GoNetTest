//
//  UITableView+Ext.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 04/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
}
