//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController, SolverDelegate {
    
    let button = UIBackgroundButton(type: .system)
    let board = UIBoard()
    let label = UILabel()
    
    func running() {
        button.isEnabled = false
        label.text = "Running..."
    }
    
    func improvement(f: Int) {
        print("solution: \(f)")
        label.text = "Current solution: \(f)"
    }
    
    func done() {
        print("solution found")
        button.isEnabled = true
        label.text = "Solution found!"
    }


    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        label.textColor = UIColor.black
        label.text = "Click to start a new one"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "buttonTapped", for: .touchUpInside)

        board.backgroundColor = UIColor.white
        board.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(board)

        label.centerHorizontal(superView: view)
        label.placeAtTop(superView: view)
        
        button.setTitle("Solve!", for: .normal)
        button.setTitle("Running!", for: .disabled)
        button.placeAtBottom(superView: view)
        button.centerHorizontal(superView: view)
        button.setWidth()
        
        board.centerVertical(superView: view)
        board.centerHorizontal(superView: view)
        board.setWidth(constant: 300)
        board.setHeight(constant: 300)
        board.initBoard()
        
        self.view = view
    }
    
    @objc func buttonTapped() {
        board.size = 10
        board.delegate = self
        board.startSolver()
        board.setNeedsDisplay()
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
