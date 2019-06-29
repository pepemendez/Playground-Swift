import Foundation

public class Dama: CustomStringConvertible{
    var renglon: Int
    var columna: Int
    var colisiones: Int
    
    public var description: String {
        return "Dama: \(renglon),\(columna) \(colisiones)"
    }
    
    init(ren: Int, col: Int, colisiones: Int) {
        self.renglon = ren
        self.columna = col
        self.colisiones = colisiones
    }
    
    public func getColumna() -> Int{
        return self.columna
    }
    
    public func setRenglon(_ renglon: Int){
        self.renglon = renglon
    }
    
    public func getColisiones() -> Int{
        return self.colisiones
    }
    
    public func addColision(){
        self.colisiones = self.colisiones + 1
    }
    
}
