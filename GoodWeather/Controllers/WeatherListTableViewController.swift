//
//  ViewController.swift
//  GoodWeather
//
//  Created by Ali Dinç on 14/10/2021.
//

import UIKit

class WeatherListTableViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCityContainerView: UIView!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Properties
    private var weatherListViewModel = WeatherListViewModel()
    private var lastUnitSelection: Unit!
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        conformToContainerDelegate()
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Unit(rawValue: value)
        }
    }

    // MARK: - Helpers
    fileprivate func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.addCityContainerView.isHidden = true
        //self.settingsButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Galvji", size: 16) ?? .systemFont(ofSize: 16)], for: .normal)
    }
    fileprivate func conformToContainerDelegate() {
        if let childVC = self.children.first as? AddWeatherCityViewController {
            childVC.delegate = self
        }
    }
    fileprivate func transition(to: UIView, tableViewHidden: Bool, viewHidden: Bool, with duration: TimeInterval) {
        UIView.transition(with: to, duration: duration, options: .transitionFlipFromTop, animations: {
            self.tableView.isHidden = tableViewHidden
            to.isHidden = viewHidden
        }, completion: nil)
    }

    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        transition(to: self.addCityContainerView, tableViewHidden: true, viewHidden: false, with: 0.4)
    }
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }
}




// MARK: - UITableViewDelegate & DataSource
extension WeatherListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UITableViewCell() }
        let weatherVM = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(weatherVM)
        return cell
    }
}

extension WeatherListTableViewController: ContainerViewToParentDelegate {
    func saveButtonTapped(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewModel(vm)
        self.tableView.reloadData()
        transition(to: addCityContainerView, tableViewHidden: false, viewHidden: true, with: 0.2)
    }
    
    func cancelButtonClicked() {
        transition(to: addCityContainerView, tableViewHidden: false, viewHidden: true, with: 0.2)
    }
}

extension WeatherListTableViewController: SettingsDelegate {
    
    func settingsDone(vm: SettingsViewModel) {
        if lastUnitSelection != nil {
            if lastUnitSelection.rawValue != vm.selectedUnit.rawValue {
                weatherListViewModel.updateUnit(to: vm.selectedUnit)
                lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)
                switch lastUnitSelection {
                case .celsius:
                    self.tempLabel.text = "C°"
                case .fahrenheit:
                    self.tempLabel.text = "F°"
                case .none:
                    self.tempLabel.text = "F°D"
                }
                tableView.reloadData()
            }
        }
    }
}
