//
//  Graficos.swift
//  AppGraficos2DEnImagenView
//
//  Created by Jose Ulloa Tovar on 07/05/25.
//

import UIKit

// 🔷 Tipo de curva
enum TipoCurva {
    case cuadratica
    case cubica
}

class Graficos2D: UIView {
    // Coordenadas
    public var x1 : Int = 0
    public var y1 : Int = 0
    public var x2 : Int = 0
    public var y2 : Int = 0
    
    public var pcx1 : Int = 0
    public var pcy1 : Int = 0
    public var pcx2 : Int = 0
    public var pcy2 : Int = 0
    
    public var ancho : Int = 0
    public var alto : Int = 0

    // 🔷 Tipo de curva a dibujar
    public var tipoCurva: TipoCurva = .cubica

    override func draw(_ rect: CGRect) {
        let canvas = UIGraphicsGetCurrentContext()
        ancho = Int(rect.width)
        alto = Int(rect.height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let componentes: [CGFloat] = [
            CGFloat(Float.random(in: 0.0..<1.0)),
            CGFloat(drand48()),
            0.0,
            1.0
        ]
        let color = CGColor(colorSpace: colorSpace, components: componentes)
        canvas?.setStrokeColor(color!)
        canvas?.setLineWidth(2.0)

        canvas?.move(to: CGPoint(x: x1, y: y1))
        
        // 🔷 Dibuja según tipo de curva
        if tipoCurva == .cuadratica {
            canvas?.addQuadCurve(to: CGPoint(x: x2, y: y2), control: CGPoint(x: pcx1, y: pcy1))
        } else {
            canvas?.addCurve(to: CGPoint(x: x2, y: y2),
                             control1: CGPoint(x: pcx1, y: pcy1),
                             control2: CGPoint(x: pcx2, y: pcy2))
        }

        canvas?.strokePath()
    }
}
