import UIKit

extension UIView {
    public func centerHorizontal(superView: UIView){
        self.centerXAnchor.constraint(equalTo: superView.layoutMarginsGuide.centerXAnchor).isActive = true
    }
    
    public func centerVertical(superView: UIView){
        self.centerYAnchor.constraint(equalTo: superView.layoutMarginsGuide.centerYAnchor).isActive = true
    }
    
    public func placeAtBottom(superView: UIView){
        self.bottomAnchor.constraint(equalTo: superView.layoutMarginsGuide.bottomAnchor, constant: -30.0).isActive = true
    }
    
    public func placeAtTop(superView: UIView){
        self.topAnchor.constraint(equalTo: superView.layoutMarginsGuide.topAnchor, constant: 30.0).isActive = true
    }
    
    public func setWidth(constant: CGFloat = 120.0){
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    public func setHeight(constant: CGFloat = 120.0){
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
