//
//  LoadingView.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 23/08/22.
//

import UIKit

class LoadingView: UIView {
    
    private let loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loading.hidesWhenStopped = true
        loading.color = .black
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        return loading
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContraints() {
        addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
