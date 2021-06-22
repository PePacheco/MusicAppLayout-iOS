//
//  CustomSlider.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 21/06/21.
//

import UIKit

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
         let point = CGPoint(x: bounds.minX, y: bounds.midY)
         return CGRect(origin: point, size: CGSize(width: bounds.width, height: 6))
     }
}
