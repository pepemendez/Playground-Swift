//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    let button = UIBackgroundButton(type: .system)
    let board = UIBoard()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "buttonTapped", for: .touchUpInside)

        board.backgroundColor = UIColor.white
        board.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.addSubview(board)

        button.setTitle("Click!", for: .normal)
        button.placeAtBottom(superView: view)
        button.centerHorizontal(superView: view)
        button.setWidth()
        
        board.centerVertical(superView: view)
        board.centerHorizontal(superView: view)
        board.setWidth(constant: 300)
        board.setHeight(constant: 300)
        
        self.view = view
    }
    
    @objc func buttonTapped() {
        board.size = 15
        board.setNeedsDisplay()
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
