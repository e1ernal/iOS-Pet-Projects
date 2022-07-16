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
    lazy var menuBtn = SortButton()
    lazy var searchBar = UISearchBar()
    var headerTableView: String = "Все результаты"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelRequest().getAllItems()
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
        self.view.backgroundColor = .black
        let constraint = Constraints.basic.rawValue
        
        self.view.addSubview(titleLbl)
        self.view.addSubview(menuBtn)
        self.view.addSubview(backToMain)
        self.view.addSubview(scoreTbl)
        
        titleLbl.text = "Результаты"
        titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        titleLbl.frame.size.height = 40
        
        let sortResultUp = UIAction(title: "Очки: max") { _ in
            scores.sort(by: { $0.score > $1.score })
            self.headerTableView = "Все результаты: очки ↓"
            self.scoreTbl.reloadData()
        }
        let sortResultDown = UIAction(title: "Очки: min") { _ in
            scores.sort(by: { $0.score < $1.score })
            self.headerTableView = "Все результаты: очки ↑"
            self.scoreTbl.reloadData()
        }
        let sortDateUp = UIAction(title: "Дата: новые") { _ in
            scores.sort(by: { $0.date ?? Date() > $1.date ?? Date() })
            self.headerTableView = "Все результаты: дата ↓"
            self.scoreTbl.reloadData()
        }
        let sortDateDown = UIAction(title: "Дата: старые") { _ in
            scores.sort(by: { $0.date ?? Date() < $1.date ?? Date() })
            self.headerTableView = "Все результаты: дата ↑"
            self.scoreTbl.reloadData()
        }
        
        let menu = UIMenu(title: "Сортировка таблицы",
                         children: [
            sortResultUp,
            sortResultDown,
            sortDateUp,
            sortDateDown
        ])
        
        menuBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        menuBtn.centerYAnchor.constraint(equalTo: titleLbl.centerYAnchor).isActive = true
        menuBtn.menu = menu
        menuBtn.showsMenuAsPrimaryAction = true
        menuBtn.setImage(.init(systemName: "arrow.up.arrow.down"), for: .normal)
        
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
        if scores.isEmpty {
            headerTableView = "Результатов нет"
        }
        return headerTableView
    }
    
    func setupTableView() {
        scoreTbl.register(CustomTableViewCell.self, forCellReuseIdentifier: "scoreCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: Helping entities
        let score = scores[indexPath.row].score
        let maxScore = scores[indexPath.row].maxScore
        let scorePercent = round(Double(100 * score / maxScore))
        let name = scores[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! CustomTableViewCell
        let rightQuestions = scores[indexPath.row].rightQuestions
        let allQuestions = scores[indexPath.row].allQuestions
        let time = scores[indexPath.row].time
        var date: String = ""
        guard let dateTime = scores[indexPath.row].date else { return cell }
        let format = DateFormatter()
        format.dateFormat = "HH:mm "
        date += format.string(from: dateTime)
        format.dateFormat = "dd.MM.yy"
        date += format.string(from: dateTime)
        
        cell.nameLabel.text = name
        cell.score.text = "\(score)"
        cell.questions.text = "\(rightQuestions)/\(allQuestions)"
        cell.perсеntLabel.text = "\(scorePercent)%"
        cell.time.text = "\(time / 60) мин \(time % 60) сек"
        cell.date.text = "\(date)"
        
        // MARK: Color Cell
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
