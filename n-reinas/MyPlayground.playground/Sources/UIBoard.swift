import UIKit

public class UIBoard: UIView {
    
    public var paint = false
    
    func paintLine() {
        let currGraphicsContext = UIGraphicsGetCurrentContext()
        
        // Draw a diagonal line.
        currGraphicsContext?.setLineWidth(2.0)
        currGraphicsContext?.setStrokeColor(UIColor.blue.cgColor)
        currGraphicsContext?.move(to: CGPoint(x: 40, y: 60)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: 32, y: 40)) // end point
        currGraphicsContext?.strokePath()
        
        // Draw a vertical line.
        currGraphicsContext?.setLineWidth(2.0)
        currGraphicsContext?.setStrokeColor(UIColor.blue.cgColor)
        currGraphicsContext?.move(to: CGPoint(x: 32, y: 40)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: 32, y: 60)) // end point
        currGraphicsContext?.strokePath()
        
        // Complete the triangle with a horizontal
        // line.
        currGraphicsContext?.setLineWidth(2.0)
        currGraphicsContext?.setStrokeColor(UIColor.blue.cgColor)
        currGraphicsContext?.move(to: CGPoint(x: 32, y: 60)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: 40, y: 60)) // end point
        currGraphicsContext?.strokePath()
    }
    
    
    override public func draw(_ rect: CGRect){
        if(paint){
            paintLine()
        }
    }
}
