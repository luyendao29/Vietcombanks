//
//  SideTableViewCell.swift
//  Vietcombanks
//
//  Created by Boss on 7/9/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit

class SideTableViewCell: UITableViewCell {
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var labelname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
