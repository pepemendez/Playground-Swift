import UIKit

public class UIBackgroundButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
        awakeFromNib()
    }
    
    override public func prepareForInterfaceBuilder() {
        awakeFromNib()
    }
    
    override public func awakeFromNib() {
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.clipsToBounds = true
    }
}
