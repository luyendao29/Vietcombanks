//
//  MenuCollectionViewCell.swift
//  Vietcombanks
//
//  Created by Boss on 7/9/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

}
