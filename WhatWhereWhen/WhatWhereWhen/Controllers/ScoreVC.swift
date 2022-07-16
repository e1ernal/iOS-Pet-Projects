//
//  ScoreVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 11.07.2022.
//

import Foundation
import UIKit

class ScoreVC: UIViewController {
    
    lazy var titleLbl = TitleLabel()
    lazy var scoreTbl = UITableView(frame: .zero, style: .insetGrouped)
    lazy var backToMain = CloseButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        setupTableView()
        scoreTbl.delegate = self
        scoreTbl.dataSource = self
        backToMain.addTarget(self, action: #selector(backToStart), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ModelRequest().getAllItems()
        scoreTbl.reloadData()
        DispatchQueue.main.async {
            self.animateTableView()
        }
    }
    
    @objc func backToStart() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ScoreVC {
    
    func makeUI() {
        let labelTitle: String = "Результаты"
        
        self.view.backgroundColor = .black
        let constraint = Constraints.basic.rawValue
        
        self.view.addSubview(titleLbl)
        self.view.addSubview(backToMain)
        self.view.addSubview(scoreTbl)
        
        titleLbl.text = labelTitle
        titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        titleLbl.frame.size.height = 40
        
        backToMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        backToMain.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor).isActive = true
    
        scoreTbl.backgroundColor = .black
        scoreTbl.translatesAutoresizingMaskIntoConstraints = false
        scoreTbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: constraint).isActive = true
        scoreTbl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scoreTbl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scoreTbl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -constraint).isActive = true
        scoreTbl.alpha = (scores.isEmpty ? 1 : 0)
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
        let normalTitle: String = "Список всех попыток"
        let emptyTitle: String = "Результатов нет"
        if scores.isEmpty {
            return emptyTitle
        } else {
            return normalTitle
        }
    }
    
    func setupTableView() {
        scoreTbl.register(CustomTableViewCell.self, forCellReuseIdentifier: "scoreCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! CustomTableViewCell
        let scorePercent = round(Double(100 * scores[indexPath.row].score / scores[indexPath.row].maxScore))
        
        cell.nameLabel.text = scores[indexPath.row].name
        cell.scoreLabel.text = String(scores[indexPath.row].score)
        cell.questions.text = "\(scores[indexPath.row].rightQuestions)/\(scores[indexPath.row].allQuestions)"
        cell.perсеntLabel.text = String(scorePercent) + "%"
        cell.time.text = String(scores[indexPath.row].time)
        cell.date.text = "01.01.21 12:34"
        cell.backgroundColor = .systemBackground.withAlphaComponent(0.15)
        switch scorePercent {
        case 0...20:
            cell.squareView.backgroundColor = .darkGray.withAlphaComponent(0.5)
        case 21...40:
            cell.squareView.backgroundColor = .red.withAlphaComponent(0.5)
        case 41...60:
            cell.squareView.backgroundColor = .yellow.withAlphaComponent(0.5)
        case 61...80:
            cell.squareView.backgroundColor = .orange.withAlphaComponent(0.5)
        case 81...100:
            cell.squareView.backgroundColor = .green.withAlphaComponent(0.5)
        default:
            cell.squareView.backgroundColor = .darkGray.withAlphaComponent(0.5)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ScoreVC {
    func animateTableView() {
        let cells = scoreTbl.visibleCells
        let tableViewHeight = scoreTbl.bounds.height
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            UIView.animate(withDuration: 2,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { [self] in
                cell.transform = CGAffineTransform.identity
                scoreTbl.alpha = 1
            })
            delay += 1
        }
    }
}
