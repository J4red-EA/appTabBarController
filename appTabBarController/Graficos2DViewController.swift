//
//  Graficos2DViewController.swift
//  appTabBarController
//
//  Created by Jared Esquivel on 23/11/25.
//

import UIKit

class Graficos2DViewController: UIViewController {

    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tituloLabel: UILabel = {
        let label = UILabel()
        label.text = "Gráficos 2D - Curvas Bézier"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let canvas: Graficos2D = {
        let canvas = Graficos2D()
        canvas.backgroundColor = UIColor.systemGray6
        canvas.layer.borderWidth = 2
        canvas.layer.borderColor = UIColor.systemBlue.cgColor
        canvas.layer.cornerRadius = 10
        canvas.translatesAutoresizingMaskIntoConstraints = false
        return canvas
    }()
    
    private let informacionLabel: UILabel = {
        let label = UILabel()
        label.text = "Punto Inicial (x1, y1) y Final (x2, y2)"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Text Fields para coordenadas
    private let txtx1 = crearTextField(placeholder: "x1")
    private let txty1 = crearTextField(placeholder: "y1")
    private let txtx2 = crearTextField(placeholder: "x2")
    private let txty2 = crearTextField(placeholder: "y2")
    
    private let controlLabel: UILabel = {
        let label = UILabel()
        label.text = "Puntos de Control (pcx1, pcy1) y (pcx2, pcy2)"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let txtpcx1 = crearTextField(placeholder: "pcx1")
    private let txtpcy1 = crearTextField(placeholder: "pcy1")
    private let txtpcx2 = crearTextField(placeholder: "pcx2")
    private let txtpcy2 = crearTextField(placeholder: "pcy2")
    
    private let labelAncho: UILabel = {
        let label = UILabel()
        label.text = "Ancho:"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelAlto: UILabel = {
        let label = UILabel()
        label.text = "Alto:"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let botonDibujarCubica: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dibujar Curva Cúbica", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let botonDibujarCuadratica: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dibujar Curva Cuadrática", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let botonMostrarDimensiones: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Mostrar Dimensiones", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Helper para crear TextFields
    static func crearTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        
        // Gesto para cerrar teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        // Agregar scroll view
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Agregar elementos al content view
        contentView.addSubview(tituloLabel)
        contentView.addSubview(canvas)
        contentView.addSubview(informacionLabel)
        
        // Stack views para organizar los text fields
        let stackInicio = crearStackHorizontal(views: [txtx1, txty1])
        let stackFinal = crearStackHorizontal(views: [txtx2, txty2])
        let stackControl1 = crearStackHorizontal(views: [txtpcx1, txtpcy1])
        let stackControl2 = crearStackHorizontal(views: [txtpcx2, txtpcy2])
        let stackDimensiones = crearStackHorizontal(views: [labelAncho, labelAlto])
        
        contentView.addSubview(stackInicio)
        contentView.addSubview(stackFinal)
        contentView.addSubview(controlLabel)
        contentView.addSubview(stackControl1)
        contentView.addSubview(stackControl2)
        contentView.addSubview(botonDibujarCubica)
        contentView.addSubview(botonDibujarCuadratica)
        contentView.addSubview(botonMostrarDimensiones)
        contentView.addSubview(stackDimensiones)
        
        // Constraints
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Título
            tituloLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            tituloLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Canvas
            canvas.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 20),
            canvas.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            canvas.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            canvas.heightAnchor.constraint(equalToConstant: 250),
            
            // Información
            informacionLabel.topAnchor.constraint(equalTo: canvas.bottomAnchor, constant: 20),
            informacionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            informacionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Stacks
            stackInicio.topAnchor.constraint(equalTo: informacionLabel.bottomAnchor, constant: 10),
            stackInicio.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackInicio.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stackFinal.topAnchor.constraint(equalTo: stackInicio.bottomAnchor, constant: 10),
            stackFinal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackFinal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            controlLabel.topAnchor.constraint(equalTo: stackFinal.bottomAnchor, constant: 20),
            controlLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            controlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stackControl1.topAnchor.constraint(equalTo: controlLabel.bottomAnchor, constant: 10),
            stackControl1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackControl1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stackControl2.topAnchor.constraint(equalTo: stackControl1.bottomAnchor, constant: 10),
            stackControl2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackControl2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Botones
            botonDibujarCubica.topAnchor.constraint(equalTo: stackControl2.bottomAnchor, constant: 20),
            botonDibujarCubica.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            botonDibujarCubica.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            botonDibujarCubica.heightAnchor.constraint(equalToConstant: 44),
            
            botonDibujarCuadratica.topAnchor.constraint(equalTo: botonDibujarCubica.bottomAnchor, constant: 10),
            botonDibujarCuadratica.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            botonDibujarCuadratica.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            botonDibujarCuadratica.heightAnchor.constraint(equalToConstant: 44),
            
            botonMostrarDimensiones.topAnchor.constraint(equalTo: botonDibujarCuadratica.bottomAnchor, constant: 10),
            botonMostrarDimensiones.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            botonMostrarDimensiones.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            botonMostrarDimensiones.heightAnchor.constraint(equalToConstant: 44),
            
            stackDimensiones.topAnchor.constraint(equalTo: botonMostrarDimensiones.bottomAnchor, constant: 10),
            stackDimensiones.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackDimensiones.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackDimensiones.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    private func crearStackHorizontal(views: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private func setupActions() {
        botonDibujarCubica.addTarget(self, action: #selector(dibujarCurvaCubica), for: .touchUpInside)
        botonDibujarCuadratica.addTarget(self, action: #selector(dibujarCurvaCuadratica), for: .touchUpInside)
        botonMostrarDimensiones.addTarget(self, action: #selector(mostrarDimensiones), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func dibujarCurvaCubica() {
        guard let x1 = Int(txtx1.text ?? ""),
              let y1 = Int(txty1.text ?? ""),
              let x2 = Int(txtx2.text ?? ""),
              let y2 = Int(txty2.text ?? ""),
              let pcx1 = Int(txtpcx1.text ?? ""),
              let pcy1 = Int(txtpcy1.text ?? ""),
              let pcx2 = Int(txtpcx2.text ?? ""),
              let pcy2 = Int(txtpcy2.text ?? "") else {
            mostrarAlerta(mensaje: "Por favor completa todos los campos con valores numéricos")
            return
        }
        
        canvas.x1 = x1
        canvas.y1 = y1
        canvas.x2 = x2
        canvas.y2 = y2
        canvas.pcx1 = pcx1
        canvas.pcy1 = pcy1
        canvas.pcx2 = pcx2
        canvas.pcy2 = pcy2
        canvas.tipoCurva = .cubica
        canvas.setNeedsDisplay()
        
        dismissKeyboard()
    }
    
    @objc private func dibujarCurvaCuadratica() {
        guard let x1 = Int(txtx1.text ?? ""),
              let y1 = Int(txty1.text ?? ""),
              let x2 = Int(txtx2.text ?? ""),
              let y2 = Int(txty2.text ?? ""),
              let pcx1 = Int(txtpcx1.text ?? ""),
              let pcy1 = Int(txtpcy1.text ?? "") else {
            mostrarAlerta(mensaje: "Por favor completa los campos necesarios (x1, y1, x2, y2, pcx1, pcy1)")
            return
        }
        
        canvas.x1 = x1
        canvas.y1 = y1
        canvas.x2 = x2
        canvas.y2 = y2
        canvas.pcx1 = pcx1
        canvas.pcy1 = pcy1
        canvas.tipoCurva = .cuadratica
        canvas.setNeedsDisplay()
        
        dismissKeyboard()
    }
    
    @objc private func mostrarDimensiones() {
        labelAncho.text = "Ancho: \(canvas.ancho)"
        labelAlto.text = "Alto: \(canvas.alto)"
        botonMostrarDimensiones.isEnabled = false
        botonMostrarDimensiones.backgroundColor = UIColor.systemGray
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
