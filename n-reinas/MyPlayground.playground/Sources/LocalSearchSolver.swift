import UIKit

public protocol SolutionDelegate: class {
    func improved(point1: Int, point2: Int)
}

public class LocalSearchSolver {
    var timeStart: Date
    var mReinas: nReinas
    var maxColisiones: Int
    
    weak var delegate: SolutionDelegate?
    
    init(reinas: Int, delegate: SolutionDelegate) {
        self.timeStart = Date()
        self.mReinas = nReinas(num_reinas: reinas)
        self.maxColisiones = mReinas.Colision()
        self.delegate = delegate
    }
    
    
    /// We need this function
    public func getTablero() -> [[Int]] {
        return self.mReinas.getTablero()
    }
    
    /// We implement our local search
    func LocalSearch() {
        let indice1 = Int.random(in: 0 ..< self.mReinas.num_reinas)
        let indice2 = Int.random(in: 0 ..< self.mReinas.num_reinas)

        self.mReinas.r.swapAt(indice1, indice2)
        
        
        let colision = self.mReinas.Colision()
        ///If we didn't improve then we just revert everything
        ///If it improve then we update our colision counter
        if(colision > maxColisiones){
            self.mReinas.r.swapAt(indice1, indice2)
        }
        else{
            self.maxColisiones = colision
            self.delegate?.improved(point1: indice1, point2: indice2)
        }
        
    }
    
    public func RunLoop(millisecs: Int){
        var colisiones = self.maxColisiones
        var newUpdateTimer = millisecs
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(millisecs)) {
            self.LocalSearch()
            
            //We want to know if something happend
            if(colisiones > self.maxColisiones){
                colisiones = self.maxColisiones
                //If improved next step is going to take more normal lenght in order to see
                //our changes
                newUpdateTimer = 0
            }
            else{
                newUpdateTimer = 0
            }
            
            // Stop the loop when the game is over
            if (self.maxColisiones > 0) {
                self.RunLoop(millisecs: newUpdateTimer)
            }
        }
    }
    
    public func Solve(){
        RunLoop(millisecs: 500)
    }
}
