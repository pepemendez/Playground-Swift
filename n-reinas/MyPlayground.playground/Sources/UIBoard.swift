import UIKit
import CoreGraphics

public protocol SolverDelegate: class{
    func running()
    func improvement(f: Int)
    func done()
    func time(seconds: Double)
}

public class UIBoard: UIView {
    //public var size = 8
    var chessLayer: CGLayer?
    var queensLayer: CGLayer?
    var queensPositions: [Int]!
    var current: [Int]!
    var point1: Int!
    var point2: Int!
    
    public weak var delegate: SolverDelegate?
    
    public func improved(point1: Int, point2: Int, current: [Int]) {
        self.point1 = point1
        self.point2 = point2
        self.current = current
        
        self.setNeedsDisplay()
    }
    
    /// If we need to set our board and put our queens in place
    func createBoard(positions: [Int]){
        current = positions
        queensLayer = nil

        queensPositions = [Int]()
        queensPositions.append(contentsOf: positions)
    }
    
    /// We initialize and paint our things
    func board() {
        //let start = Date()

        let currGraphicsContext = UIGraphicsGetCurrentContext()
        
        drawChess(currGraphicsContext: currGraphicsContext)
        drawQueens(currGraphicsContext: currGraphicsContext)
        drawBorders(currGraphicsContext: currGraphicsContext)
       
        /*let now = Date()
        let time =  now.timeIntervalSince(start)
        
        delegate?.time(seconds: time)*/
    }
    
    public func initBoard(positions: [Int]){
        chessLayer = nil
        createBoard(positions: positions)
    }
    
    /// We draw our circles
    func drawQueens(currGraphicsContext: CGContext?){
        guard let current = self.current else { return }

        let queenPng = #imageLiteral(resourceName: "Queen.png")
        let reinas = current
        let size = current.count
        let width = self.frame.width/CGFloat(size)
        
        if(queensLayer == nil){
            print("queensLayer nil")
            queensLayer = CGLayer(currGraphicsContext!, size: CGSize(width: self.frame.width, height: self.frame.height), auxiliaryInfo: nil)
            
            let layerContext = queensLayer?.context
            layerContext?.setFillColor(UIColor.red.cgColor)
            
            for i in 0 ..< size {
                drawQueen(currGraphicsContext: layerContext, queen: queenPng, x: reinas[i], y: i)
            }
        }
        else{
            let layerContext = queensLayer?.context
            
            layerContext?.setFillColor(UIColor.red.cgColor)
            
            //We remove our previous positions
            layerContext?.clear(CGRect(x: width*CGFloat(queensPositions[point1]), y: width*CGFloat(point1), width: width, height: width))
            layerContext?.clear(CGRect(x: width*CGFloat(queensPositions[point2]), y: width*CGFloat(point2), width: width, height: width))
            
            
            //We draw our new positions
            drawQueen(currGraphicsContext: layerContext, queen: queenPng, x: reinas[point1], y: point1)
            drawQueen(currGraphicsContext: layerContext, queen: queenPng, x: reinas[point2], y: point2)
            
            //We update our new positions
            self.queensPositions.removeAll()
            self.queensPositions.append(contentsOf: self.current)
        }
        
        currGraphicsContext?.draw(queensLayer!, at: CGPoint(x: 0, y: 0))
    }
    
    func drawQueen(currGraphicsContext: CGContext?,queen: UIImage, x: Int, y: Int){
        let size = self.current.count
        let width = self.frame.width/CGFloat(size)

        //We draw our background
        currGraphicsContext?.fillEllipse(in:
            CGRect(x: width*CGFloat(x), y: width*CGFloat(y), width: width, height: width))
        
        //We draw our queen

        if let context = currGraphicsContext{
            UIGraphicsPushContext(context);
            
            queen.draw(in: CGRect(x:width*CGFloat(x), y: width*CGFloat(y), width: width, height: width))
            
            UIGraphicsPopContext();

        }
    }
    
    /// We draw our black squares since white ones are provided by our background
    func drawChess(currGraphicsContext: CGContext?){
        if let layer = self.getBlackSquares(currGraphicsContext: currGraphicsContext){
            currGraphicsContext?.draw(layer, at: CGPoint(x: 0, y: 0))
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
    
    func getBlackSquares(currGraphicsContext: CGContext?) -> CGLayer?{
        let size = self.current.count
        let width = self.frame.width/CGFloat(size)
        
        if(chessLayer == nil){
            var blackSquares = [CGRect]()
            for i in 0 ..< size {
                let y = width*CGFloat(i)
                
                for j in stride(from: i % 2, to: size, by: 2){
                    blackSquares.append(CGRect(x: width*CGFloat(j), y: y, width: width, height: width))
                }
            }
            
            chessLayer = CGLayer(currGraphicsContext!, size: CGSize(width: self.frame.width, height: self.frame.height), auxiliaryInfo: nil)
            
            let layerContext = chessLayer?.context
            
            layerContext?.setFillColor(UIColor.black.cgColor)
            layerContext?.fill(blackSquares)
        }
        
        return chessLayer
    }

    override public func draw(_ rect: CGRect){
        board()
    }
}
