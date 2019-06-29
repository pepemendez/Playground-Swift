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
    
    func board() {
        let currGraphicsContext = UIGraphicsGetCurrentContext()
        
        for i in 0 ... 8 {
            currGraphicsContext?.setLineWidth(2.0)
            currGraphicsContext?.setStrokeColor(UIColor.black.cgColor)
            currGraphicsContext?.move(to: CGPoint(x: (self.frame.width/CGFloat(8))*CGFloat(i), y: 0)) // begin point
            currGraphicsContext?.addLine(to: CGPoint(x: (self.frame.width/CGFloat(8))*CGFloat(i), y: self.frame.height)) // end point
            currGraphicsContext?.strokePath()

            currGraphicsContext?.move(to: CGPoint(x: 0, y: (self.frame.width/CGFloat(8))*CGFloat(i))) // begin point
            currGraphicsContext?.addLine(to: CGPoint(x: self.frame.width, y: (self.frame.width/CGFloat(8))*CGFloat(i))) // end
            currGraphicsContext?.strokePath()

        }
    }

    
    override public func draw(_ rect: CGRect){
        if(paint){
            paintLine()
        }
        else{
            board()
        }
    }
}
