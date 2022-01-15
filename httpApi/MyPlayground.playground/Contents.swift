//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

import Foundation


class MyViewController : UIViewController {
    
    let label = UILabel()
    let button = UIBackgroundButton(type: .system)

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.isOpaque = true

        label.textColor = UIColor.black
        label.text = "Hello world"
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
            
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button.setTitle("Buscar", for: .normal)
        button.setTitle("Buscando", for: .disabled)
        button.frame = CGRect(x: 100, y: 400, width: 200, height: 20)
        
        view.addSubview(label)
        view.addSubview(button)
        
        self.view = view
    }
    
    @objc func buttonTapped(){

    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
