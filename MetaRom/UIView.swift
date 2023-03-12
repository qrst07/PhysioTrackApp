import UIKit

extension UIView {

    func disableSubviewsForUserInteraction() {
        for subView in subviews {
            subView.isUserInteractionEnabled = false
        }
    }

}

extension UITextField {
       
    func setLeftView(with image: UIImage? = nil, imageFrame: CGRect? = nil, leftViewFrame: CGRect) {
        let containerView = UIView(frame: leftViewFrame)
        
        if let leftImage = image, let leftImageFrame = imageFrame {
            let imageView = UIImageView(image: leftImage)
            imageView.frame = leftImageFrame
            imageView.contentMode = .center
            containerView.addSubview(imageView)
        }
        
        leftView = containerView
        leftViewMode = .always
    }


    func setRightView(with image: UIImage? = nil, imageFrame: CGRect? = nil, rightViewFrame: CGRect) {
        let containerView = UIView(frame: rightViewFrame)
        
        if let rightImage = image, let rightImageFrame = imageFrame {
            let imageView = UIImageView(image: rightImage)
            imageView.frame = rightImageFrame
            imageView.contentMode = .center
            containerView.addSubview(imageView)
        }
        
        rightView = containerView
        rightViewMode = .always
    }

}


extension UIView {

    func addGradient(type: CAGradientLayerType! = .axial,
                       startPoint: CGPoint,
                       endPoint: CGPoint,
                       colorArray: [UIColor],
                       fillColor: UIColor? = nil,
                       locations: [NSNumber]? = nil) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })

        let gradientLayer = CAGradientLayer()
        gradientLayer.type = type
        
        if let locations = locations{
            gradientLayer.locations = locations
        }
        
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        if let fillColor = fillColor {
            backgroundColor = fillColor
        }else{
            backgroundColor = .clear
        }
        
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }


    func addShadow(color: UIColor,
                   alpha: Float,
                   x: CGFloat,
                   y: CGFloat,
                   blur: CGFloat,
                   spread: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

    func roundCorners(topLeft: CGFloat = 0,
                   topRight: CGFloat = 0,
                   bottomLeft: CGFloat = 0,
                   bottomRight: CGFloat = 0) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

    func addBorder(color: CGColor,
                   lineWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = (layer.mask! as! CAShapeLayer).path!
        borderLayer.strokeColor = color
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = lineWidth + 1
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }

}

extension NSLayoutConstraint{

    func with(priority: UILayoutPriority) -> NSLayoutConstraint
    {
        self.priority = priority
        return self
    }
}
