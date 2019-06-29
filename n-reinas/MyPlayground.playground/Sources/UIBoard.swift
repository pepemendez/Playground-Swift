import UIKit

public class UIBoard: UIView {
    
    var size = 8
    
    func board() {
        let currGraphicsContext = UIGraphicsGetCurrentContext()
        for i in 0 ... size {
            for j in 0 ... size {
                if( (i + j) % 2 == 0 ){
                    currGraphicsContext?.setFillColor(UIColor.white.cgColor)
                }
                else{
                    currGraphicsContext?.setFillColor(UIColor.black.cgColor)
                }
                
                currGraphicsContext?.fill(CGRect(x: (self.frame.width/CGFloat(size))*CGFloat(i),
                                                 y: (self.frame.width/CGFloat(size))*CGFloat(j),
                                                 width: self.frame.width/CGFloat(size),
                                                 height: self.frame.width/CGFloat(size)))



            }
        }
        
        currGraphicsContext?.setLineWidth(1.0)
        currGraphicsContext?.setStrokeColor(UIColor.black.cgColor)
        currGraphicsContext?.move(to: CGPoint(x: 0, y: 0)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: 0, y: self.frame.height)) // end point
        currGraphicsContext?.strokePath()
        
        currGraphicsContext?.move(to: CGPoint(x: self.frame.width, y: 0)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height)) // end point
        currGraphicsContext?.strokePath()

        currGraphicsContext?.move(to: CGPoint(x: 0, y: 0)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: self.frame.width, y: 0)) // end
        currGraphicsContext?.strokePath()
        
        currGraphicsContext?.move(to: CGPoint(x: 0, y: self.frame.height)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height)) // end
        currGraphicsContext?.strokePath()
    }

    override public func draw(_ rect: CGRect){
        board()
    }
}
