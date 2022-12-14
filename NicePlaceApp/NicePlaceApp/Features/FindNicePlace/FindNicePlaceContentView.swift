//
//  FindNicePlaceContentView.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 25/08/22.
//

import UIKit

protocol FindNicePlaceContentViewDelegate: AnyObject {
    typealias SubmittedContent = (category: String, radius: Int?)
    func submitContent(submittedContent: SubmittedContent)
    func incorrectContent(error: TextfieldError)
}

class FindNicePlaceContentView: UIView {
    weak var delegate: FindNicePlaceContentViewDelegate?
    
    let contentSearchView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = NSLocalizedString("categoryTextField_placeholder", comment: "")
        textField.backgroundColor = UIColor(named: "CustomBackground")
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let radiusTextField: UITextField = {
        let textField = UITextField()
         textField.placeholder = NSLocalizedString("radiusTextField_placeholder", comment: "")
        textField.backgroundColor = UIColor(named: "CustomBackground")
        textField.layer.cornerRadius = 5
        textField.keyboardType = .asciiCapableNumberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("searchButton_title", comment: ""), for: .normal)
        button.backgroundColor = UIColor(named: "BackgroundColor")
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        return button
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.backgroundColor = .systemGray6

        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func searchButtonAction() {
        if let radius = Int(radiusTextField.text ?? ""), (radius < 0 || radius > 100000) {
            delegate?.incorrectContent(error: .outOfRadiusValueLimit)
            return
        }
        
        if let category = categoryTextField.text, category != "" {
            delegate?.submitContent(submittedContent: (category, Int(radiusTextField.text ?? "")))
        } else {
            delegate?.incorrectContent(error: .emptyTextfield)
        }
    }
}

// MARK: - Setup View
extension FindNicePlaceContentView {
    
    private func setupContentView() {
        addSubview(contentSearchView)
        contentSearchView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(categoryTextField)
        contentStackView.addArrangedSubview(radiusTextField)
        contentStackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            contentSearchView.topAnchor.constraint(equalTo: topAnchor),
            contentSearchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentSearchView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentSearchView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
                
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentSearchView.topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: contentSearchView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: contentSearchView.trailingAnchor, constant: -8),
            contentStackView.bottomAnchor.constraint(equalTo: contentSearchView.bottomAnchor, constant: -8)
        ])
    }
}
