//
//  ProtoTableViewCell.swift
//  VtoU
//
//  Created by JungGue LEE on 2024/02/15.
//

import UIKit

class ProtoTableViewCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var how: UILabel!
    @IBOutlet weak var much: UILabel!
    
    @IBOutlet weak var viewcell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewcell.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
