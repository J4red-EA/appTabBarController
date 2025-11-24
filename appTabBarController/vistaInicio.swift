//
//  vistaInicio.swift
//  appTabBarController
//
//  Created by Jared Esquivel on 21/11/25.
//

import UIKit

class vistaInicio: UIViewController {
    
    // MARK: - UI Elements
    private let tituloLabel: UILabel = {
        let label = UILabel()
        label.text = "Bienvenido"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtituloLabel: UILabel = {
        let label = UILabel()
        label.text = "Tab Bar Controller App"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descripcionLabel: UILabel = {
        let label = UILabel()
        label.text = "Usa los tabs de abajo para navegar entre las diferentes secciones de la aplicación."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Agregar subvistas
        view.addSubview(iconImageView)
        view.addSubview(tituloLabel)
        view.addSubview(subtituloLabel)
        view.addSubview(descripcionLabel)
        
        // Configurar constraints
        NSLayoutConstraint.activate([
            // Icono
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Título
            tituloLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 30),
            tituloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Subtítulo
            subtituloLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 10),
            subtituloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtituloLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Descripción
            descripcionLabel.topAnchor.constraint(equalTo: subtituloLabel.bottomAnchor, constant: 30),
            descripcionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            descripcionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}
