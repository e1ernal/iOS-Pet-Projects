//
//  ScoreVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation
import UIKit

class ScoreVC: UIViewController {
    
    /* CoreData update */
    var scores = [1, 4, 5, 13, 12, 7, 3]
    
    lazy var titleLbl = TitleLabel()
    lazy var backToStartBtn = RegularButton()
    lazy var scoreTbl: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        setupTableView()
        scoreTbl.delegate = self
        scoreTbl.dataSource = self
        backToStartBtn.addTarget(self, action: #selector(backToStart), for: .touchUpInside)
    }
    
    @objc func backToStart() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ScoreVC {
    
    func makeUI() {
        let labelTitle: String = "Результаты"
        let backToNewGameTitle: String = "Вернуться к началу игры"
        
        self.view.backgroundColor = .black
        let constraint = Constraints.basic.rawValue
        
        self.view.addSubview(titleLbl)
        self.view.addSubview(backToStartBtn)
        self.view.addSubview(scoreTbl)
        
        titleLbl.text = labelTitle
        titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        titleLbl.frame.size.height = 40
        
        backToStartBtn.setTitle(backToNewGameTitle, for: .normal)
        backToStartBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        backToStartBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        backToStartBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constraint).isActive = true
        
        scoreTbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: constraint).isActive = true
        scoreTbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        scoreTbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        scoreTbl.bottomAnchor.constraint(equalTo: backToStartBtn.topAnchor, constant: -constraint).isActive = true
    }
}

extension ScoreVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "По количеству набранных очков"
    }
    
    func setupTableView() {
        scoreTbl.register(CustomTableViewCell.self, forCellReuseIdentifier: "scoreCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scoreTbl.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! CustomTableViewCell
        
        let score = scores[indexPath.row]
        let maxScore = scores.count
        let attempt = indexPath.row + 1
        
        cell.attemptLabel.text = "Попытка №\(attempt)"
        cell.scoreLabel.text = "Набрано: \(score) из \(maxScore)"
        
        switch indexPath.row {
            case 0:
                cell.rewardLabel.text = Reward.first.rawValue
                cell.backgroundColor = .systemGreen.withAlphaComponent(0.7)
            case 1:
                cell.rewardLabel.text = Reward.second.rawValue
                cell.backgroundColor = .systemGreen.withAlphaComponent(0.5)
            case 2:
                cell.rewardLabel.text = Reward.third.rawValue
                cell.backgroundColor = .systemGreen.withAlphaComponent(0.3)
            default: cell.rewardLabel.text = Reward.other.rawValue
        }
        return cell
    }
}
