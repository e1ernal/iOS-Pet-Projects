//
//  CustomTableView.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 09.07.2022.
//

import Foundation
import UIKit

class CustomTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .insetGrouped)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func reloadData() {
        setup()
        self.reloadData()
    }
    func setup() {
        self.clipsToBounds = true
        self.backgroundColor = .green
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
