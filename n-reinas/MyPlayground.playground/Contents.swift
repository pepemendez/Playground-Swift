//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

///Solver functions according to each posible state
extension MyViewController {
    func started(){
        start = Date()
        mainView.changeState(state: .running)
    }
    
    func improvement(f: Int, point1: Int, point2: Int, current: [Int]) {
        mainView.improveBoard(point1: point1, point2: point2, current: current)
        mainView.printMessage(msg: "Current solution: \(f)")
    }
    
    func done() {
        let time = Date().timeIntervalSince(start)
        print("solution found in \(time)")
        
        mainView.changeState(state: .solved)
    }
}

extension MyViewController: SolutionDelegate {
    func running() {
        started()
    }
    
    func improved(point1: Int, point2: Int, current: [Int]) {
        if(solver.maxColisiones > 0){
            improvement(f: solver.maxColisiones, point1: point1, point2: point2, current: current)
        }
        else{
            done()
        }
    }
}
 
extension MyViewController: MainInterfaceDelegate {
    func startButtonTapped() {
        self.solver = LocalSearchSolver(reinas: 20, delay: 100, delegate: self)
        self.mainView.initBoard(positions: self.solver.currentSolution)
        solver.Solve()
    }
}

class MyViewController : UIViewController {
    var start = Date()
    var mainView: UIReinas!
    var solver: LocalSearchSolver!
    
    override func viewDidLoad(){
        self.solver = LocalSearchSolver(reinas: 10, delegate: self)
        self.mainView.initBoard(positions: self.solver.currentSolution)
    }

    override func loadView() {
        mainView = UIReinas(delegate: self)
        mainView.setContraints(mainView)
        self.view = mainView
        
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
