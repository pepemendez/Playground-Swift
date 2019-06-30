import UIKit

public protocol SolverDelegate: class{
    func running()
    func improvement(f: Int)
    func done()
    func time(seconds: Double)
}

/// I tried to create clusters for our queens, at best for 250 queens our drawing time
/// pass from 0.0005~ to 0.0001, isn't worthing
public class UIBoard: UIView, SolutionDelegate {
    public var size = 8
    var tablero2: LocalSearchSolver!
    var blackSquare = [CGRect]()
    var chessLayer: CGLayer?

    public weak var delegate: SolverDelegate?
    
    /// If we need to update our solutions
    public func improved() {
        if(tablero2.maxColisiones > 0){
            delegate?.improvement(f: tablero2.maxColisiones)
        }
        else{
            delegate?.done()
        }
        
        self.setNeedsDisplay()
    }
    
    /// If we need to set our board and put our queens in place
    func createBoard(){
        self.tablero2 = LocalSearchSolver(reinas: size, delegate: self)
    }
    
    /// We initialize and paint our things
    func board() {
        let start = Date()

        let currGraphicsContext = UIGraphicsGetCurrentContext()
        
        drawChess(currGraphicsContext: currGraphicsContext)
        drawBorders(currGraphicsContext: currGraphicsContext)
        drawQueens(currGraphicsContext: currGraphicsContext)
        
        let now = Date()
        let time =  now.timeIntervalSince(start)
        
        delegate?.time(seconds: time)
    }
    
    public func initBoard(){
        createBoard()
    }
    
    public func startSolver(){
        print("Starting solver")
        delegate?.running()
        createBoard()
        tablero2.Solve()
    }
    
    /// We draw our circles
    func drawQueens(currGraphicsContext: CGContext?){
        var reinas = tablero2.mReinas.r
        let width = self.frame.width/CGFloat(size)

        currGraphicsContext?.setFillColor(UIColor.red.cgColor)
        
        for i in 0 ..< size {
            currGraphicsContext?.fillEllipse(in:
                CGRect(x: width*CGFloat(reinas[i]),
                       y: width*CGFloat(i),
                       width: width,
                       height: width))
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
        let width = self.frame.width/CGFloat(size)
        
        if(blackSquare.count < 1){
            for i in 0 ..< size {
                let y = width*CGFloat(i)
                
                var j = i % 2
                
                repeat{
                    blackSquare.append(CGRect(x: width*CGFloat(j),
                                              y: y,
                                              width: width,
                                              height: width))
                    j += 2
                } while j < size
                
            }
        }
        
        if(chessLayer == nil){
            chessLayer = CGLayer(currGraphicsContext!, size: CGSize(width: self.frame.width, height: self.frame.height), auxiliaryInfo: nil)
            
            let layerContext = chessLayer?.context
            
            layerContext?.setFillColor(UIColor.black.cgColor)
            layerContext?.fill(blackSquare)
        }
        
        return chessLayer
    }

    override public func draw(_ rect: CGRect){
        board()
    }
}
