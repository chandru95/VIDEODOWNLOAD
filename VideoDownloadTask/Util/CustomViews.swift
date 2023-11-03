//
//  CustomViews.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import Foundation
import SJFrameSwift
import UIKit
import QuartzCore



//================================================//
//MARK: - Custom ImageView Local
//================================================//
class CustomViewLocal: SJView {
    var textChange: Bool = false {
        didSet {
            backgroundColor = textChange ? UIColor.init(named: "FieldBgGray"): .clear
        }
    }
    override open func draw(_ rect: CGRect) {
//        setLocalisation()
        setCornerRadius()
    }

    override func layoutSubviews() {
        setCornerRadius()
    }

    func refreshUI() {
//        setLocalisation()
        setCornerRadius()
    }


    @IBInspectable public var localization:Bool = false {
        didSet{
//            setLocalisation()
        }
    }

   
    @IBInspectable public var clipToCircle:Bool = false{
        didSet{
            setCornerRadius()
        }
    }

    func setContainerViewBorderColor(error:Bool) {
        if error {
            self.borderColor = UIColor(named: "ErrorRed")!
            self.backgroundColor = UIColor(named: "ErrorLightRedBg")!
        }else {
            self.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
            self.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        }
    }


    func setCornerRadius() {
        if clipToCircle {
            if(self.frame.size.width>self.frame.size.height){
                self.layer.cornerRadius = self.frame.size.height/2
            }else{
                self.layer.cornerRadius = self.frame.size.width/2
            }
            self.clipsToBounds = true
        }
    }

    @IBInspectable public var rotationAngle: CGFloat = 0.0 {
        didSet {
//            setRotationAngle()
        }
    }

    
}




//================================================//
//MARK: - Custom Scroll Local
//================================================//
@IBDesignable
class CustomViewShadow:UIView {

    override open func draw(_ rect: CGRect) {
        //removeShadow()
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = Float(shadowOpacity)
    }

    override func layoutSubviews() {
        removeShadow()
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = Float(shadowOpacity)
    }

    func removeShadow() {
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowOpacity = 0.0
    }

    @IBInspectable public var shadowRadius:CGFloat = 0.0 {
        didSet{
            setShadowRadius()
        }
    }

    @IBInspectable public var shadowColour:UIColor = UIColor.gray {
        didSet{
            setShadowColour()
        }
    }

    @IBInspectable public var shadowOffset:CGSize = CGSize(width: 0, height: 0) {
        didSet{
            setShadowOffset()
        }
    }

    @IBInspectable public var shadowOpacity:CGFloat = 0.3 {
        didSet{
            setShadowOpacity()
        }
    }

    private func setShadowRadius() {
        self.layer.shadowRadius = shadowRadius
    }

    private func setShadowColour() {
        self.layer.shadowColor = shadowColour.cgColor
    }

    private func setShadowOffset() {
        self.layer.shadowOffset = shadowOffset
    }

    private func setShadowOpacity() {
        self.layer.shadowOpacity = Float(shadowOpacity)
    }

}

//========================================================
//MARK: -
//========================================================
@IBDesignable
class CustomViewGradient: CustomViewLocal {

    var colourStart:UIColor = UIColor.gray
    var colourEnd:UIColor = UIColor.darkGray
    var startPoint:CGPoint = CGPoint(x: 0, y: 0)
    var endPoint:CGPoint = CGPoint(x: 0, y: 0)
    var layerTopGradient:CAGradientLayer?

    override open func draw(_ rect: CGRect) {
        applyGradient()
    }

    override func layoutSubviews() {
        applyGradient()
    }

    @IBInspectable
    public var ColourStart:UIColor = UIColor.gray{
        didSet{
            colourStart = ColourStart
        }
    }

    @IBInspectable
    public var ColourEnd:UIColor = UIColor.darkGray{
        didSet{
            colourEnd = ColourEnd
        }
    }

    @IBInspectable
    public var StartPoint:CGPoint = CGPoint(x: 0.5, y: 0){
        didSet{
            startPoint = StartPoint
        }
    }

    @IBInspectable
    public var EndPoint:CGPoint = CGPoint(x: 0.5, y: 1){
        didSet{
            endPoint = EndPoint
        }
    }

    func applyGradient() {
        if let layerGradient = layerTopGradient {
            layerGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            layerGradient.startPoint = startPoint
            layerGradient.endPoint = endPoint
            layerGradient.colors = [colourStart.cgColor,colourEnd.cgColor]
        }else{
            layerTopGradient = CAGradientLayer()
            layerTopGradient?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            layerTopGradient?.startPoint = startPoint
            layerTopGradient?.endPoint = endPoint
            layerTopGradient?.colors = [colourStart.cgColor,colourEnd.cgColor]
            self.layer.insertSublayer(layerTopGradient!, at: 0)
        }
    }

}

class CustomCornerView: CustomViewLocal {

    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            setCornerRadiusIndividual()
        }
    }

    @IBInspectable public var topLeft:Bool = false {
        didSet {
            setCornerRadiusIndividual()
        }
    }

    @IBInspectable public var topRight:Bool = false {
        didSet {
            setCornerRadiusIndividual()
        }
    }

    @IBInspectable public var bottomLeft:Bool = false {
        didSet {
            setCornerRadiusIndividual()
        }
    }

    @IBInspectable public var bottomRight:Bool = false {
        didSet {
            setCornerRadiusIndividual()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        setCornerRadiusIndividual()
    }

    private func setCornerRadiusIndividual() {

        var corners: [CACornerMask]  = []

        if topLeft {
            corners.append(.layerMinXMinYCorner)
        }

        if topRight {
            corners.append(.layerMaxXMinYCorner)
        }

        if bottomLeft {
            corners.append(.layerMinXMaxYCorner)
        }

        if bottomRight {
            corners.append(.layerMaxXMaxYCorner)
        }

        self.layer.maskedCorners = CACornerMask(corners)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}

// MARK: - Custom Shadow XD
@IBDesignable class CustomShadowXD: UIView {

    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGPoint {
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }

     }

    @IBInspectable var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue / 2.0
        }
    }

    @IBInspectable var shadowSpread: CGFloat = 0 {
        didSet {
            if shadowSpread == 0 {
                layer.shadowPath = nil
            } else {
                let dx = -shadowSpread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                layer.shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
    }
}

    //MARK:
class CustomViewController: SJViewController {
    private var viewLoaderWithTouchThrough:UIView?
    private var isKeyboardNotificationsRegistered:Bool = false


//    public func showLoaderWithUserInteractionEnabled() -> Void {
//        DispatchQueue.main.async {
//            if let view = self.viewLoaderWithTouchThrough{
//                view.frame = view.bounds;
//            }else{
//                self.viewLoaderWithTouchThrough = CustomAPILoader(frame: self.view.bounds);
//                self.viewLoaderWithTouchThrough?.frame = self.view.bounds
//                //                self.viewLoaderWithTouchThrough?.backgroundColor = .red
//                //                self.viewLoaderWithTouchThrough?.alpha = 0.2
//                self.viewLoaderWithTouchThrough?.isUserInteractionEnabled = false
//            }
//            self.view.addSubview(self.viewLoaderWithTouchThrough!);
//        }
//    }

    public func hideLoaderWithUserInteractionEnabled() -> Void {
        DispatchQueue.main.async {
            if let view = self.viewLoaderWithTouchThrough{
                UIView.animate(withDuration: 0.3, animations: {
                    view.layer.opacity = 0;
                }, completion: { (status) in
                    view.removeFromSuperview();
                    self.viewLoaderWithTouchThrough = nil;
                });

            }
        }
    }
}



