import Foundation

public class nReinas {
    public var num_reinas: Int
    public var r: [Int]
    public var stablero: String
    
    init(num_reinas: Int) {
        self.num_reinas = num_reinas
        self.stablero = String()
        self.r = [Int](repeating: 0, count: num_reinas)
        
        for c in 0 ..< num_reinas{
            self.r[c] = c
        }
    }
    
    public func getTablero() -> [[Int]] {
        var tablero = [[Int]](repeating: [Int](repeating: 0, count: self.num_reinas), count: self.num_reinas)
        
        for i in 0 ..< self.num_reinas {
            tablero[i][r[i]] = 1
        }
        
        return tablero
    }
    
    public func Colision() -> Int {
        var indicador = 0
        var raux = [Int]()
        raux.append(contentsOf: self.r)
        
        for ren in 0 ..< self.num_reinas {
            var i = 1
            while (ren + i < self.num_reinas && raux[ren] + i < self.num_reinas) {
                if (raux[ren + i] == raux[ren] + i) {
                    indicador += 1;
                }
                i += 1;
            }
            
            var i2 = 1;
            while (ren + i2 < self.num_reinas && raux[ren] - i2 >= 0) {
                if (raux[ren + i2] == raux[ren] - i2) {
                    indicador += 1;
                }
                i2 += 1;
            }
        }
        
        return indicador;
    }
    
    public func Comprobacion() -> Int {
        var tablero = [Int](repeating: 0, count: num_reinas)
        var reinas = 0
        for i in 0 ..< self.num_reinas {
            if (canPlaceQueen(row: i, col: self.r[i])) {
                tablero[i] = self.r[i];
                reinas += 1;
            }
        }
        
        return reinas
    }
    
    public static func isConsistent(q: [Int], n: Int) -> Bool {
        for i in 0 ..< n {
            if (q[i] == q[n] || q[i] - q[n] == n - i || q[n] - q[i] == n - i) {
                return false;
            }
        }
        return true;
    }
    
    public func canPlaceQueen(row: Int, col: Int) -> Bool{
        for i in 0 ..< row {
            if (self.r[i] == col || i - row == self.r[i] - col || i - row == col - self.r[i]) {
                return false;
            }
        }
        
        return true;
    }
}
