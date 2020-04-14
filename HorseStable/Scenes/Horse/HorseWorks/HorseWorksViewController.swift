//
//  HorseWorksViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 31/10/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol HorseWorksViewControlling {
    var coordinator: HorseWorksCoordinating? {get set}
}

class HorseWorksViewController: UIViewController, HorseWorksViewControlling {    
    
    var viewModel: HorseWorksViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var coordinator: HorseWorksCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Works for \(viewModel.horse.name)"
        
        setupUI()
        viewModel.delegate = self
        viewModel.updateWorks()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        tableView.register(HorseWorksCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear HORSE")
        viewModel.updateWorks()
        tableView.reloadData()
    }
    
    @objc func add() {
        coordinator?.add()
    }
    
    func setupUI() {
    }
    
}

extension HorseWorksViewController: HorseWorksViewModelDelegate {
    func didUpdate(isBusy: Bool) {
    }
    
    func didFail(with error: Error) {
        print(error)
    }
    
    func didUpdateWorks() {
        tableView.reloadData()
    }
    
    func didDeleteWork() {
        viewModel.updateWorks()
    }
}

extension HorseWorksViewController: UITableViewDelegate {
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

extension HorseWorksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfWorks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let work = viewModel.work(at: indexPath.row)
        cell.textLabel?.text = work.name
        cell.detailTextLabel?.text = "Horse: \(work.horseID)"
        return cell
    }
}
