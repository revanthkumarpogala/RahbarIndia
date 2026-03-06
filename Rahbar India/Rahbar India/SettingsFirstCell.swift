//
//  SettingsFirstCell.swift
//  Rahbar India
//
//  Created by revanth kumar on 06/03/26.
//

import UIKit

class SettingsFirstCell: UITableViewCell {

    @IBOutlet weak var header: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Utilities().setInterRegular(label: header, size: 15)
        header.textColor = UIColor.hexStringToUIColor(hex: "000000")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHedar(title: String) {
        header.text = title
    }
}
