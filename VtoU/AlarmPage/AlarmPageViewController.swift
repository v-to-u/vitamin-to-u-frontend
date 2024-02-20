//
//  AlarmPageViewController.swift
//  VtoU
//
//  Created by JungGue LEE on 2024/01/29.
//

import Foundation
import UIKit

class AlarmPageViewController: UIViewController {
        
    @IBOutlet weak var week2: UIButton!
    @IBOutlet weak var week1: UIButton!
    @IBOutlet weak var week3: UIButton!
    @IBOutlet weak var week4: UIButton!
    @IBOutlet weak var week5: UIButton!
    @IBOutlet weak var week6: UIButton!
    @IBOutlet weak var week7: UIButton!
    
    @IBOutlet weak var day1: UIButton!
    @IBOutlet weak var day2: UIButton!
    @IBOutlet weak var day3: UIButton!
    @IBOutlet weak var day4: UIButton!
    @IBOutlet weak var day5: UIButton!
    @IBOutlet weak var day6: UIButton!
    @IBOutlet weak var day7: UIButton!
    
    @IBOutlet weak var PillView: UITableView!
    
    let time = ["08:00", "12:00", "18:00","20:00"]
    let name = ["비타민C","판콜","오메가3","타이레놀"]
    let how = ["식후 복용","식후 복용","식후 복용","복용"]
    let much = ["2정","1포","1정","1정"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PillView.dataSource = self
        PillView.rowHeight = UITableView.automaticDimension
        PillView.estimatedRowHeight = 500
        
    }

    
}

extension AlarmPageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PillView.dequeueReusableCell(withIdentifier: "ProtoTableViewCell", for: indexPath) as! ProtoTableViewCell
        cell.time.text = time[indexPath.row]
        cell.name.text = name[indexPath.row]
        cell.how.text = how[indexPath.row]
        cell.much.text = much[indexPath.row]
        return cell
    }
}
