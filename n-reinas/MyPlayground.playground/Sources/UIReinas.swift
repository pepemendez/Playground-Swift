import Foundation
import UIKit

public enum AlgorithmState {
    case running
    case solved
}

public protocol MainInterfaceDelegate: AnyObject{
    func startButtonTapped()
}

public class UIReinas: UIView {
    weak var delegate: MainInterfaceDelegate?
    
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
    
    public init(delegate: MainInterfaceDelegate){
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        self.backgroundColor = .white
        self.isOpaque = true
        self.addSubview(label)
        self.addSubview(button)
        self.addSubview(board)
        setContraints(self)

        button.addTarget(self, action:#selector(self.buttonTapped), for: .touchUpInside )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func setContraints(_ view: UIView){
        label.centerHorizontal(superView: view)
        label.placeAtTop(superView: view)
        
        button.placeAtBottom(superView: view)
        button.centerHorizontal(superView: view)
        button.setWidth()
        
        board.centerVertical(superView: view)
        board.centerHorizontal(superView: view)
        board.setWidth(constant: 300)
        board.setHeight(constant: 300)
    }
    
    public func initBoard(positions: [Int]){
        board.initBoard(positions: positions)
        board.setNeedsDisplay()
    }
    
    public func improveBoard(point1: Int, point2: Int, current: [Int]){
        board.improved(point1: point1, point2: point2, current: current)
    }
    
    public func printMessage(msg: String){
        label.text = msg
    }
    
    public func changeState(state: AlgorithmState){
        switch state {
            case .running:
                button.isEnabled = false
                label.text = "Running..."
                break
            case .solved:
                button.isEnabled = true
                label.text = "Solution found!"
                break
        }
    }
    
    @objc func buttonTapped() {
        delegate?.startButtonTapped()
    }
}
