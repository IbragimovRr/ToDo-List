//
//  MainCollectionViewCell.swift
//  ToDo List
//
//  Created by Руслан on 07.09.2024.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    func selectBtn(bool: Bool) {
        if bool {
            selectedBtn.layer.borderColor = UIColor.clear.cgColor
            selectedBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }else {
            selectedBtn.layer.borderWidth = 2
            selectedBtn.layer.borderColor = UIColor.blackGray.cgColor
            selectedBtn.imageView?.image = nil
        }
    }
    
    @IBOutlet weak var selectedBtn: UIButton!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descripionText: UILabel!
    @IBOutlet weak var mainText: UILabel!
}
