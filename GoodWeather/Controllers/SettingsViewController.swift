//
//  SettingsViewController.swift
//  GoodWeather
//
//  Created by Ali Dinç on 15/10/2021.
//

import Foundation
import UIKit

protocol SettingsDelegate: AnyObject {
    func settingsDone(vm: SettingsViewModel)
}

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    private var settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            delegate.settingsDone(vm: settingsViewModel)
        }
        self.dismiss(animated: true)
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.units.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsItem = settingsViewModel.units[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        if settingsItem == settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        cell.textLabel?.text = settingsItem.displayName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // uncheck all cells
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            settingsViewModel.selectedUnit = unit
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
}
