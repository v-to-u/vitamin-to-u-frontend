//
//  AlarmMakerViewContrller.swift
//  VtoU
//
//  Created by JungGue LEE on 2024/02/17.
//

import Foundation
import UIKit

class AlarmMakerViewController: UIViewController {

    @IBOutlet weak var done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func donebtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
