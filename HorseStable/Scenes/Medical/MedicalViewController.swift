//
//  MedicalViewController.swift
//  HorseStable
//
//  Created by Lukas Korinek on 25/11/2019.
//  Copyright © 2019 Lukas Korinek. All rights reserved.
//

import UIKit

protocol MedicalViewControlling {
    var done: (() -> Void)? { get set }
    var coordinator: MedicalCoordinating? {get set}
}

class MedicalViewController: UIViewController, MedicalViewControlling {
    var done: (() -> Void)?
    
    var viewModel: MedicalViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinator: MedicalCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateMedical()
        navigationItem.title = "Medical"
        viewModel.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        tableView.register(HorseWorksCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear MEDICAL")
        viewModel.updateMedical()
        tableView.reloadData()
    }
    
    @objc func add() {
        coordinator?.add()
    }
}

extension MedicalViewController: MedicalViewModelDelegate {
    func didUpdateMedical() {
        tableView.reloadData()
    }
    
    func didUpdate(isBusy: Bool) {
    }
    
    func didFail(with error: Error) {
        print(error)
    }
}

extension MedicalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let medical = viewModel.medical(at: indexPath.row)
    }
}

extension MedicalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMedical()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let medical = viewModel.medical(at: indexPath.row)
        cell.textLabel?.text = medical.name
        return cell
    }
}
