//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension MyViewController: SolverDelegate {
    func time(seconds: Double) {
        print("time \(seconds)")
    }
    
    func running() {
        start = Date()
        mainView.changeState(state: .running)
    }
    
    func improvement(f: Int) {
        mainView.printMessage(msg: "Current solution: \(f)")
    }
    
    func done() {
        let time =   Date().timeIntervalSince(start)
        print("solution found in \(time)")
        
        mainView.changeState(state: .solved)
    }
}

extension MyViewController: SolutionDelegate {
    func runningSolver() {
        start = Date()
        mainView.changeState(state: .running)
    }
    
    func improved(point1: Int, point2: Int, current: [Int]) {
        board.improved(point1: point1, point2: point2, current: current)
        
        if(solver.maxColisiones > 0){
                   improvement(f: solver.maxColisiones)
               }
       else{
           done()
       }
    }
}
 
extension MyViewController: MainInterfaceDelegate {
    func startButtonTapped() {
        self.solver = LocalSearchSolver(reinas: 20, delegate: self)
        board.initBoard(positions: self.solver.currentSolution)
        board.setNeedsDisplay()
        solver.Solve()
    }
}

class MyViewController : UIViewController {
    
    var start = Date()
    var mainView: UIReinas!
    var solver: LocalSearchSolver!
    
    public func solverFinished() -> Bool{
        return solver.maxColisiones > 0
    }

    let board: UIBoard = {
        let board = UIBoard()
        board.backgroundColor = UIColor.white
        board.isOpaque = true
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
    override func viewDidLoad(){
        self.solver = LocalSearchSolver(reinas: 12, delegate: self)
        board.initBoard(positions: self.solver.currentSolution)
        board.delegate = self
    }

    override func loadView() {
        mainView = UIReinas(delegate: self)
        mainView.addSubview(board)
        setContraints(mainView)
        self.view = mainView
    }
    
    func setContraints(_ view: UIView){
        board.centerVertical(superView: view)
        board.centerHorizontal(superView: view)
        board.setWidth(constant: 300)
        board.setHeight(constant: 300)
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
