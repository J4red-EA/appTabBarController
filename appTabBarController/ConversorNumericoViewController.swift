//
//  ConversorNumericoViewController.swift
//  appTabBarController
//
//  Created by Jared Esquivel on 23/11/25.
//

import UIKit

class ConversorNumericoViewController: UIViewController {
    
    // MARK: - UI Elements
    private let tituloLabel: UILabel = {
        let label = UILabel()
        label.text = "Conversor Numérico"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ingresa un número decimal"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let convertirButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Convertir", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resultadosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let binarioLabel: UILabel = {
        let label = UILabel()
        label.text = "Binario: -"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let octalLabel: UILabel = {
        let label = UILabel()
        label.text = "Octal: -"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let hexadecimalLabel: UILabel = {
        let label = UILabel()
        label.text = "Hexadecimal: -"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        
        // Agregar gesto para cerrar el teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        // Agregar subvistas
        view.addSubview(tituloLabel)
        view.addSubview(inputTextField)
        view.addSubview(convertirButton)
        view.addSubview(resultadosStackView)
        
        // Agregar labels al stack view
        resultadosStackView.addArrangedSubview(binarioLabel)
        resultadosStackView.addArrangedSubview(octalLabel)
        resultadosStackView.addArrangedSubview(hexadecimalLabel)
        
        // Configurar constraints
        NSLayoutConstraint.activate([
            // Título
            tituloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tituloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Input TextField
            inputTextField.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 30),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Botón Convertir
            convertirButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            convertirButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            convertirButton.widthAnchor.constraint(equalToConstant: 200),
            convertirButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Stack View de Resultados
            resultadosStackView.topAnchor.constraint(equalTo: convertirButton.bottomAnchor, constant: 40),
            resultadosStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultadosStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupActions() {
        convertirButton.addTarget(self, action: #selector(convertirNumero), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func convertirNumero() {
        guard let texto = inputTextField.text,
              let numeroDecimal = Int(texto) else {
            mostrarAlerta(mensaje: "Por favor ingresa un número válido")
            return
        }
        
        // Realizar conversiones
        let binario = String(numeroDecimal, radix: 2)
        let octal = String(numeroDecimal, radix: 8)
        let hexadecimal = String(numeroDecimal, radix: 16).uppercased()
        
        // Mostrar resultados
        binarioLabel.text = "Binario: \(binario)"
        octalLabel.text = "Octal: \(octal)"
        hexadecimalLabel.text = "Hexadecimal: \(hexadecimal)"
        
        // Cerrar teclado
        dismissKeyboard()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func mostrarAlerta(mensaje: String) {
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }
}
