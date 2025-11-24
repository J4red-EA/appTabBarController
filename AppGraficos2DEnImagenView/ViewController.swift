//
//  ViewController.swift
//  AppGraficos2DEnImagenView
//
//  Created by Jose Ulloa Tovar on 07/05/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvas: Graficos2D!
    @IBOutlet weak var txtx1: UITextField!
    @IBOutlet weak var txty1: UITextField!
    @IBOutlet weak var txtx2: UITextField!
    @IBOutlet weak var txty2: UITextField!
    @IBOutlet weak var labelAncho: UILabel!
    @IBOutlet weak var labelAlto: UILabel!
    @IBOutlet weak var txtpcx1: UITextField!
    @IBOutlet weak var txtpcy1: UITextField!
    @IBOutlet weak var txtpcx2: UITextField!
    @IBOutlet weak var txtpcy2: UITextField!
    @IBOutlet weak var botonAA: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    // 🔷 Dibuja curva cúbica
//    @IBAction func botonDibujar(_ sender: UIButton) {
//        self.canvas.x1 = Int(txtx1.text!)!
//        self.canvas.y1 = Int(txty1.text!)!
//        self.canvas.x2 = Int(txtx2.text!)!
//        self.canvas.y2 = Int(txty2.text!)!
//
//        self.canvas.pcx1 = Int(txtpcx1.text!)!
//        self.canvas.pcy1 = Int(txtpcy1.text!)!
//        self.canvas.pcx2 = Int(txtpcx2.text!)!
//        self.canvas.pcy2 = Int(txtpcy2.text!)!
//
//        self.canvas.tipoCurva = .cubica
//        self.canvas.setNeedsDisplay()
//    }
    @IBAction func botonDibujar(_ sender: UIButton) {
        guard let x1 = Int(txtx1.text ?? ""),
              let y1 = Int(txty1.text ?? ""),
              let x2 = Int(txtx2.text ?? ""),
              let y2 = Int(txty2.text ?? ""),
              let pcx1 = Int(txtpcx1.text ?? ""),
              let pcy1 = Int(txtpcy1.text ?? ""),
              let pcx2 = Int(txtpcx2.text ?? ""),
              let pcy2 = Int(txtpcy2.text ?? "") else {
            // Aquí puedes mostrar una alerta o mensaje de error
            print("Error: uno o más campos están vacíos o contienen datos no válidos.")
            return
        }

        self.canvas.x1 = x1
        self.canvas.y1 = y1
        self.canvas.x2 = x2
        self.canvas.y2 = y2
        self.canvas.pcx1 = pcx1
        self.canvas.pcy1 = pcy1
        self.canvas.pcx2 = pcx2
        self.canvas.pcy2 = pcy2

        self.canvas.tipoCurva = .cubica
        self.canvas.setNeedsDisplay()
    }

    
    // 🔷 Muestra el tamaño del canvas
    @IBAction func botonAnchoAlto(_ sender: UIButton) {
        labelAncho.text! += " " + String(self.canvas.ancho)
        labelAlto.text! += " " + String(self.canvas.alto)
        botonAA.isEnabled = false
    }

    // 🔷 Dibuja curva cuadrática (nuevo botón)
    @IBAction func botonCurvaCuadratica(_ sender: UIButton) {
        self.canvas.x1 = Int(txtx1.text!)!
        self.canvas.y1 = Int(txty1.text!)!
        self.canvas.x2 = Int(txtx2.text!)!
        self.canvas.y2 = Int(txty2.text!)!
        
        self.canvas.pcx1 = Int(txtpcx1.text!)!
        self.canvas.pcy1 = Int(txtpcy1.text!)!
        
        self.canvas.tipoCurva = .cuadratica
        self.canvas.setNeedsDisplay()
    }
}
