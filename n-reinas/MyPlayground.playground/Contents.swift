//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController, SolverDelegate {
    
    var start = Date()
    let button = UIBackgroundButton(type: .system)
    let board = UIBoard()
    let label = UILabel()
    
    func time(seconds: Double) {
        print("time \(seconds)")
    }
    
    func running() {
        start = Date()
        button.isEnabled = false
        label.text = "Running..."
    }
    
    func improvement(f: Int) {
        label.text = "Current solution: \(f)"
    }
    
    func done() {
        let now = Date()
        let time =  now.timeIntervalSince(start)
        print("solution found in \(time)")
        button.isEnabled = true
        label.text = "Solution found!"
    }


    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.isOpaque = true
        
        label.textColor = UIColor.black
        label.text = "Click to solve"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "buttonTapped", for: .touchUpInside)

        board.size = 12
        board.backgroundColor = UIColor.white
        board.isOpaque = true
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
        board.delegate = self
        board.startSolver()
        board.setNeedsDisplay()
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
