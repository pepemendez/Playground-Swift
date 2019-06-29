//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class UIBackgroundButton: UIButton {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        awakeFromNib()
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.clipsToBounds = true
    }
    
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Hola mundo!"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIBackgroundButton(type: .system)
        
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(button)
        
        label.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -30.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        button.setTitle("Click!", for: .normal)
        
        self.view = view
    }
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
