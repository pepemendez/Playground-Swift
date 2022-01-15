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
 
extension MyViewController: MainInterfaceDelegate {
    func startButtonTapped() {
        board.startSolver()
        board.setNeedsDisplay()
    }
}

class MyViewController : UIViewController {
    
    var start = Date()
    var mainView: UIReinas!
    
    let board: UIBoard = {
        let board = UIBoard()
        board.backgroundColor = UIColor.white
        board.isOpaque = true
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    
    override func viewDidLoad(){
        board.size = 12
        board.initBoard()
        
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
