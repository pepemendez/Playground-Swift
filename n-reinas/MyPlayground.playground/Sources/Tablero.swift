import Foundation

public class Tablero: CustomStringConvertible{
    let tamaño: Int!
    var damas = [Dama]()
    var tablero: [[Int]]
    var colisiones: Int!
    
    public var description: String {
        return "Tablero: \(tamaño!) \(colisiones!) \(damas) \(tablero)"
    }

    
    /// Iniciamos la matriz en 0's
    init(tamaño: Int) {
        self.tamaño = tamaño
        self.tablero = [[Int]](repeating: [Int](repeating: 0, count: tamaño), count: tamaño)
        self.colisiones = 0
    }
    
    /// Iniciamos la matriz en 0's y añadimos las damas al tablero
    init(renglones: [Int]) {
        self.tamaño = renglones.count
        self.tablero = [[Int]](repeating: [Int](repeating: 0, count: tamaño), count: tamaño)
        self.colisiones = 0
        
        var i = 0;
        
        for arreglo in renglones {
            insertarDama(renglon: arreglo, columna: i)
            i = i + 1
        }
    }
    
    public func getTablero() -> [[Int]] {
        return self.tablero
    }
    
    public func getColisiones() -> Int {
        return self.colisiones
    }
    
    public func getDamas() -> [Dama] {
        return self.damas
    }
    
    /// Insertamos una dama en el tablero y actualizamos el contador de colisiones
    /**
     *
     * Para indicar la presencia de una dama escribimos un 1
     *
     * Si quisieramos agregar una dama en alguna ficha donde
     * una reina anterior coma lo que hacemos es agregar el numero de reinas
     * que comen a esta ficha, lo cual es igual a el valor absoluto de
     * el numero que este en dicha celda, se marco con negativo para indicar
     * que no existe una reina ahi, pero que de existir el numero nos indica
     * con cuantas reinas tendria colision
     *
     * [ 1][-2][-1][-2]
     * [-2][-2][-1][ 0]
     * [-2][ 1][-2][-1]
     * [-2][-1][-1][-1]
     *
     * al insertar una nueva en la posicion (3,3)
     *
     * [ 2][-2][-2][-2]
     * [-2][-3][-2][-1]
     * [-3][ 2][ 3][-2]
     * [-2][-2][-2][-2]
     *
     *
     * Colisiones
     *
     * Se suma un 1 a una reina marcando una colision, es decir el numero
     * de colisiones de una reina  esta dado por su numero-1
     *
     * Los caminos en donde las reinas comen estan marcados con numeros
     * negativos, es decir si una celda tiene un -3 quiere decir que 3
     * reinas pueden comer a una reina colocada en este punto
     *
     *
     * @param renglon
     * @param columna
     *
     */
    public func insertarDama(renglon: Int, columna: Int){
    
        self.damas.append(Dama(ren: renglon, col: columna, colisiones: self.tablero[renglon][columna] * -1));
    
        self.tablero[renglon][columna] = 1 + damas[columna].getColisiones();
        
        /* Diagonal Superior Izquierda */
        var i = 1
        while ((renglon - i >= 0)&&(columna - i >= 0))
        {
            if(self.tablero[renglon-i][columna-i] > 0)
            {
                self.tablero[renglon-i][columna-i] += 1; //Colisiones
                self.colisiones += 1;
                self.damas[columna-i].addColision();
            }
            else{
                self.tablero[renglon-i][columna-i] -= 1;
            }
            
            i += 1
        }
        
        i = 1
    
        while ((renglon + i < self.tamaño)&&(columna + i < self.tamaño))
        {
            if(self.tablero[renglon+i][columna+i] > 0)
            {
                self.tablero[renglon+i][columna+i] += 1; //Colisiones
                self.colisiones += 1;
                self.damas[columna+i].addColision();
            }
            else{
                self.tablero[renglon+i][columna+i] -= 1;
            }
            
            i += 1
        }
    
        /* Diagonal Derecha */
        
        i = 1
        
        while ((renglon+i < self.tamaño)&&(columna-i >= 0))
        {
            if(self.tablero[renglon+i][columna-i] > 0)
            {
                self.tablero[renglon+i][columna-i] += 1;
                self.colisiones += 1;
                self.damas[columna-i].addColision();
            }
            else{
                self.tablero[renglon+i][columna-i] -= 1;
            }
            
            i += 1
        }
        
        i = 1
        
        while ((renglon-i >= 0)&&(columna+i < self.tamaño))
        {
            if(self.tablero[renglon-i][columna+i] > 0)
            {
                self.tablero[renglon-i][columna+i] += 1;
                self.colisiones += 1 ;
                self.damas[columna+i].addColision();
            }
            else{
                self.tablero[renglon-i][columna+i] -= 1;
            }
            
            i += 1
        }
        
        /* Vertical */
        
        i = 1
        
        while (renglon-i >= 0)
        {
            if(self.tablero[renglon-i][columna] > 0)
            {
                self.tablero[renglon-i][columna] += 1;
                self.colisiones += 1;
                self.damas[columna].addColision();
            }
            else{
                self.tablero[renglon-i][columna] -= 1;
            }
            
            i += 1
        }
        
        i = 1
        
        while (renglon+i < self.tamaño)
        {
            if(self.tablero[renglon+i][columna] > 0)
            {
                self.tablero[renglon+i][columna] += 1;
                self.colisiones += 1;
                self.damas[columna].addColision();
            }
            else{
                self.tablero[renglon+i][columna] -= 1;
            }
            
            i += 1
        }
        
        /* Horizontal */
        
        i = 1
        
        while (columna-i >= 0)
        {
            if(self.tablero[renglon][columna-i] > 0)
            {
                self.tablero[renglon][columna-i] += 1;
                self.colisiones += 1;
                self.damas[columna-i].addColision();
            }
            else{
                self.tablero[renglon][columna-i] -= 1;
            }
            
            i += 1
        }
        
        i = 1
        
        while (columna+i < self.tamaño)
        {
            if(self.tablero[renglon][columna+i] > 0)
            {
                self.tablero[renglon][columna+i] += 1;
                self.colisiones += 1;
                self.damas[columna+i].addColision();
            }
            else{
                self.tablero[renglon][columna+i] -= 1;
            }
            
            i += 1
        }
    }
}
