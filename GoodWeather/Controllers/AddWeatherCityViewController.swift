//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by Ali Dinç on 14/10/2021.
//

import UIKit

protocol ContainerViewToParentDelegate: AnyObject {
    func cancelButtonClicked()
    func saveButtonTapped(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: ContainerViewToParentDelegate?
    private var addWeatherVM = AddWeatherViewModel()
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewForContainerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewForContainerView()
    }

    // MARK: - Helpers
    func setupViewForContainerView() {
        self.saveButton.isHidden = true
        self.view.backgroundColor = .clear
        self.contentView.layer.cornerRadius = 80
        self.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
        self.contentView.layer.masksToBounds = false
        //self.view.backgroundColor = UIColor(named: "WeatherFontColor")
        self.contentView.addShadow(xAxis: 0, yAxis: 4, shadowRadius: 6, color: .black, shadowOpacity: 1)
        self.cityNameTextField.attributedPlaceholder = NSAttributedString(string: "type your city...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.cityNameTextField.autocorrectionType = .no
        self.cityNameTextField.autocapitalizationType = .words
    }

    
    // MARK: - Actions
    fileprivate func clearTextField() {
        self.cityNameTextField.text = ""
        self.cityNameTextField.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.cancelButtonClicked()
        clearTextField()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let city = cityNameTextField.text {
            addWeatherVM.addWeather(for: city) { vm in
                self.delegate?.saveButtonTapped(vm: vm)
                self.clearTextField()
            }
        }
    }
}



// MARK: - UITextField
extension AddWeatherCityViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = cityNameTextField.text else { return }
        if text.count > 0 {
            UIView.transition(with: self.saveButton, duration: 1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.saveButton.isHidden = false
            }, completion: nil)
        }
    }
}


