//
//  StartVC.swift
//  WhatWhereWhen
//
//  Created by Dmitry Smirnykh on 08.07.2022.
//

import Foundation
import UIKit

class StartVC: UIViewController {
    
    var characters = ["Результат 1: 10/15", "Результат 2: 2/15", "Результат 3: 7/15", "Результат 4: 6/15", "Результат 5: 8/15", "Результат 6: 10/15", "Результат 7: 11/15", "Результат 8: 15/15", "Результат 9: 9/15", "Результат 1: 10/15"]
    
    lazy var titleLbl = TitleLabel()
    lazy var startBtn = RegularButton()
//    lazy var scoreTable = UITableView()
    lazy var scoreTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .black
        tableView.sizeToFit()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        setupTableView()
        startBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        scoreTable.delegate = self
        scoreTable.dataSource = self
    }
    
    @objc func buttonAction() {
        let nextVC: QuestionsVC = QuestionsVC()
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
}

extension StartVC {
    
    func makeUI() {
        let labelTitle: String = """
                                 15 вопросов из игры
                                 <Что? Где? Когда?>
                                 """
        let buttonTitle: String = "Начать играть"
        
        self.view.backgroundColor = .black
        let constraint = Constraints.basic.rawValue
        
        self.view.addSubview(titleLbl)
        self.view.addSubview(startBtn)
        self.view.addSubview(scoreTable)
        
        titleLbl.text = labelTitle
        titleLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: constraint).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -constraint).isActive = true
        
        startBtn.setTitle(buttonTitle, for: .normal)
        startBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        startBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        /* Remove later */ scoreTable.translatesAutoresizingMaskIntoConstraints = false
        scoreTable.topAnchor.constraint(equalTo: startBtn.bottomAnchor, constant: constraint).isActive = true
        scoreTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraint).isActive = true
        scoreTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraint).isActive = true
        scoreTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constraint).isActive = true
    }
}

extension StartVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Результаты"
    }
    
    func setupTableView() {
        scoreTable.register(UITableViewCell.self, forCellReuseIdentifier: "scoreCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scoreTable.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row]
        /* Remove later */ cell.backgroundColor = .darkGray
        /* Remove later */ cell.textLabel?.textColor = .white
        return cell
    }
}
