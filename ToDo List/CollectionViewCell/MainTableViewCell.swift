//
//  MainTableViewCell.swift
//  ToDo List
//
//  Created by Руслан on 07.09.2024.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    func strikeText(strike : String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: strike)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }

    
    func selectBtn(bool: Bool) {
        if bool {
//            mainText.attributedText = strikeText(strike: mainText.text!)
            selectedBtn.layer.borderColor = UIColor.clear.cgColor
            selectedBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }else {
            selectedBtn.layer.borderWidth = 2
            selectedBtn.layer.borderColor = UIColor.blackGray.cgColor
            selectedBtn.setImage(UIImage(), for: .normal)
        }
    }
    
    @IBOutlet weak var selectedBtn: UIButton!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var descripionText: UILabel!
    @IBOutlet weak var mainText: UILabel!
}
