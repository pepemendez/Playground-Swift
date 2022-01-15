//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension MyViewController: SolverDelegate {
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
}

class MyViewController : UIViewController {
    
    var start = Date()
    let board: UIBoard = {
        let board = UIBoard()
        board.backgroundColor = UIColor.white
        board.isOpaque = true
        board.translatesAutoresizingMaskIntoConstraints = false
        return board
    }()
    let button: UIBackgroundButton = {
        let button = UIBackgroundButton(type: .system)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Solve!", for: .normal)
        button.setTitle("Running!", for: .disabled)
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Click to solve"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.isOpaque = true
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(board)
        
        label.centerHorizontal(superView: view)
        label.placeAtTop(superView: view)
        
        button.placeAtBottom(superView: view)
        button.centerHorizontal(superView: view)
        button.setWidth()
        
        board.centerVertical(superView: view)
        board.centerHorizontal(superView: view)
        board.setWidth(constant: 300)
        board.setHeight(constant: 300)

        self.view = view
    }
    
    override func viewDidLoad(){
        board.size = 12
        board.initBoard()
        
        board.delegate = self
        button.addTarget(self, action:#selector(self.buttonTapped), for: .touchUpInside )
    }
    
    @objc func buttonTapped() {
        board.startSolver()
        board.setNeedsDisplay()
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
