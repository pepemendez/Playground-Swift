import UIKit

public class UIBoard: UIView {
    
    var solve = false
    public var size = 8
    var tablero: Tablero!
    
    /// If we need to set our board and put our queens in place
    func createBoard(){
        self.tablero = Tablero(tamaño: size)
        
        for i in 0 ..< size {
            tablero.insertarDama(renglon: i, columna: i)
        }
    }
    
    
    /// We initialize and paint our things
    func board() {
        if(!solve){
            createBoard()
        }
        
        let currGraphicsContext = UIGraphicsGetCurrentContext()
        
        drawChess(currGraphicsContext: currGraphicsContext)
        drawBorders(currGraphicsContext: currGraphicsContext)
    }
    
    
    /// We draw our squares and we check if for some square there is a queen, if it's then we draw a circle
    func drawChess(currGraphicsContext: CGContext?){
        for i in 0 ..< size {
            for j in 0 ..< size {
                if( (i + j) % 2 == 0 ){
                    currGraphicsContext?.setFillColor(UIColor.white.cgColor)
                }
                else{
                    currGraphicsContext?.setFillColor(UIColor.black.cgColor)
                }
                
                currGraphicsContext?.fill(CGRect(x: (self.frame.width/CGFloat(size))*CGFloat(j),
                                                 y: (self.frame.width/CGFloat(size))*CGFloat(i),
                                                 width: self.frame.width/CGFloat(size),
                                                 height: self.frame.width/CGFloat(size)))
                
                if(tablero.getTablero()[i][j] > 0){
                    currGraphicsContext?.setFillColor(UIColor.red.cgColor)
                    
                    currGraphicsContext?.fillEllipse(in: CGRect(x: (self.frame.width/CGFloat(size))*CGFloat(j),
                                                                y: (self.frame.width/CGFloat(size))*CGFloat(i),
                                                                width: self.frame.width/CGFloat(size),
                                                                height: self.frame.width/CGFloat(size)))
                    
                }
                
            }
        }
        
    }
    
    /// We draw the outer borders for our chess board
    func drawBorders(currGraphicsContext: CGContext?){
        currGraphicsContext?.setLineWidth(1.0)
        currGraphicsContext?.setStrokeColor(UIColor.black.cgColor)
        
        //Left
        currGraphicsContext?.move(to: CGPoint(x: 0, y: 0)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: 0, y: self.frame.height)) // end point
        currGraphicsContext?.strokePath()
        
        //Right
        currGraphicsContext?.move(to: CGPoint(x: self.frame.width, y: 0)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height)) // end point
        currGraphicsContext?.strokePath()
        
        //Top
        currGraphicsContext?.move(to: CGPoint(x: 0, y: 0)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: self.frame.width, y: 0)) // end
        currGraphicsContext?.strokePath()
        
        //Bottom
        currGraphicsContext?.move(to: CGPoint(x: 0, y: self.frame.height)) // begin point
        currGraphicsContext?.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height)) // end
        currGraphicsContext?.strokePath()
    }

    override public func draw(_ rect: CGRect){
        board()
    }
}
