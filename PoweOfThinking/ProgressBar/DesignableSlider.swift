//
//  DesignableSlider.swift
//  PoweOfThinking
//
//  Created by bora on 30.10.2020.
//

import Foundation

import UIKit
@IBDesignable open class DesignableSlider: UISlider {

    @IBInspectable var trackHeight: CGFloat = 5

    @IBInspectable var roundImage: UIImage? {
        didSet{
            setThumbImage(roundImage, for: .normal)
        }
    }
    @IBInspectable var roundHighlightedImage: UIImage? {
        didSet{
            setThumbImage(roundHighlightedImage, for: .highlighted)
        }
    }
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        //set your bounds here
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
    }
}
