//
//  WorksViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 23/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit
import FSCalendar

protocol WorksViewControlling {
    var coordinator: WorksCoordinating? {get set}
}

class WorksViewController: UIViewController, WorksViewControlling {
    
    var viewModel: WorksViewModel!
    
    var currentDate = Date()

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    var coordinator: WorksCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.firstWeekday = 2
        calendar.today = nil
        calendar.scrollDirection = .vertical
        calendar.select(Date())
        navigationItem.title = "Works"
        
        setupUI()
        viewModel.delegate = self
        viewModel.updateWorks()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        tableView.register(WorkCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear WORK")
        viewModel.updateWorks()
        tableView.reloadData()
        calendar.reloadData()
    }
    
    @objc func add() {
        coordinator?.add(date: currentDate)
    }
    
    func setupUI() {
    }
    
}

extension WorksViewController: WorksViewModelDelegate {
    func didUpdate(isBusy: Bool) {
    }
    
    func didFail(with error: Error) {
        print(error)
    }
    
    func didUpdateWorks() {
        tableView.reloadData()
        calendar.reloadData()
    }
    
    func didDeleteWork() {
        viewModel.updateWorks()
    }
}

extension WorksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let work = viewModel.work(at: indexPath.row)
        
        coordinator?.select(with: work)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {(_,_,_) in
            let horse = self.viewModel.work(at: indexPath.row)
            self.viewModel.delete(identifier: horse.id)
            print("DELETE \(horse.id)")
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension WorksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfWorks(date: currentDate)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let work = viewModel.work(at: indexPath.row)
        cell.textLabel?.text = work.name
        cell.detailTextLabel?.text = "Horse: \(work.horseID) Date: \(work.date)"
        return cell
    }
}

extension WorksViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDate = date
        tableView.reloadData()
    }
    
}

extension WorksViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return viewModel.works.filter { (work) -> Bool in
            work.date == Formatter().getYYYYMMDD(from: date)
        }.count
    }
}
