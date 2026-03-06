//
//  SettingsSecondCell.swift
//  Rahbar India
//
//  Created by revanth kumar on 06/03/26.
//

import UIKit
protocol SettingsSecondCellDelegate: AnyObject {
    func didSelectCell(index: Int)
}

class SettingsSecondCell: UITableViewCell {

    var delegate: SettingsSecondCellDelegate?
    @IBOutlet weak var header: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        Utilities().setMulishSemiBold(label: header, size: 20)
        header.text = "Follow us"
        header.textColor = UIColor.hexStringToUIColor(hex: "000000")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func linkedInTapped(_ sender: Any) {
        delegate?.didSelectCell(index: 2)
    }
    @IBAction func instaTapped(_ sender: Any) {
        delegate?.didSelectCell(index: 1)
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        delegate?.didSelectCell(index: 3)
    }
    @IBAction func fbTapped(_ sender: Any) {
        delegate?.didSelectCell(index: 0)
    }
}
