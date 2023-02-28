//
//  ViewController.swift
//  magic-8ball
//
//  Created by serhan on 28.02.23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var magicLabel: UILabel!
    @IBOutlet weak var blueCircle: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        blueCircle.isHidden = true
        magicLabel.isHidden = true
        
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            
            magicLabel.isHidden = false
            blueCircle.isHidden = false
            
            Animation()
            
            let randomNumber = Int.random(in: 0...19)
            
            if let path = Bundle.main.path(forResource: "magic-8ball", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: Any]]
                    
                    if let data = json[randomNumber]["text"] {
                        magicLabel.text = "\(data)"
                    }
                    
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    
    func Animation() {
        
        self.magicLabel.alpha = 0
        self.blueCircle.alpha = 0
        
        UIView.animate(withDuration: 4, animations: {
            
            self.magicLabel.alpha = 1
            self.blueCircle.alpha = 1
            
        }, completion: nil)
        
        
    }
    
}
