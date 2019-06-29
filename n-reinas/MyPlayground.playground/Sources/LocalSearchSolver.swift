import UIKit

public protocol SolutionDelegate: class {
    func improved()
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
        
        print(self.mReinas.r)
        self.mReinas.r.swapAt(indice1, indice2)
        print(self.mReinas.r)

        //swap(&self.mReinas.r[indice1], &self.mReinas.r[indice2])
        
        let colision = self.mReinas.Colision()
        
        ///If we didn't improve then we just revert everything
        ///If it improve then we update our colision counter
        if(colision > maxColisiones){
            print("revert \(colision) > \(maxColisiones)")
            self.mReinas.r.swapAt(indice1, indice2)
            
            //swap(&self.mReinas.r[indice1], &self.mReinas.r[indice2])
        }
        else{
            maxColisiones = colision
        }
        
    }
    
    public func Solve(){
        var colisiones = self.maxColisiones
        
        repeat {
            print(colisiones)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                // Put your code which should be executed with a delay here
                self.LocalSearch()
            })
            
            print("LocalSearch")
            
            if(colisiones > maxColisiones){
                print("improved")
                colisiones = maxColisiones
                DispatchQueue.main.async{
                    // Put your code which should be executed with a delay here
                    self.delegate?.improved()
                }
            }
        } while maxColisiones > 0
    }
}
